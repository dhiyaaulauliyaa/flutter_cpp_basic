#include <jni.h>
#include <string>
#include <sstream>
#include <algorithm>
#include <cctype>
#include <vector>
#include <ctime>
#include "data_transformer.h"

std::string DataTransformer::transformJson(const std::string& jsonString) {
    // Add metadata and analysis to the JSON
    return addMetadata(jsonString);
}

std::string DataTransformer::analyzeText(const std::string& text) {
    return extractTextStats(text);
}

std::string DataTransformer::convertFormat(const std::string& data, const std::string& fromFormat, const std::string& toFormat) {
    if (fromFormat == "csv" && toFormat == "json") {
        return csvToJson(data);
    } else if (fromFormat == "json" && toFormat == "xml") {
        return jsonToXml(data);
    }
    
    // Return original data if conversion is not supported
    return data;
}

std::string DataTransformer::extractTextStats(const std::string& text) {
    int wordCount = 0;
    int charCount = text.length();
    int sentenceCount = 0;
    bool inWord = false;
    
    for (char c : text) {
        if (std::isspace(c)) {
            if (inWord) {
                wordCount++;
                inWord = false;
            }
            if (c == '.' || c == '!' || c == '?') {
                sentenceCount++;
            }
        } else {
            inWord = true;
        }
    }
    
    // Count the last word if the text doesn't end with space
    if (inWord) {
        wordCount++;
    }
    
    std::ostringstream jsonStream;
    jsonStream << "{";
    jsonStream << "\"wordCount\": " << wordCount << ",";
    jsonStream << "\"charCount\": " << charCount << ",";
    jsonStream << "\"sentenceCount\": " << sentenceCount;
    jsonStream << "}";
    
    return jsonStream.str();
}

std::string DataTransformer::csvToJson(const std::string& csvData) {
    std::istringstream lineStream(csvData);
    std::string line;
    std::vector<std::string> headers;
    std::vector<std::vector<std::string>> rows;
    
    // Read headers
    if (std::getline(lineStream, line)) {
        std::istringstream cellStream(line);
        std::string cell;
        while (std::getline(cellStream, cell, ',')) {
            headers.push_back(cell);
        }
    }
    
    // Read data rows
    while (std::getline(lineStream, line)) {
        std::vector<std::string> row;
        std::istringstream cellStream(line);
        std::string cell;
        while (std::getline(cellStream, cell, ',')) {
            row.push_back(cell);
        }
        if (row.size() == headers.size()) {
            rows.push_back(row);
        }
    }
    
    // Convert to JSON
    std::ostringstream jsonStream;
    jsonStream << "[";
    
    for (size_t i = 0; i < rows.size(); i++) {
        jsonStream << "{";
        for (size_t j = 0; j < headers.size(); j++) {
            jsonStream << "\"" << headers[j] << "\": \"" << rows[i][j] << "\"";
            if (j < headers.size() - 1) {
                jsonStream << ",";
            }
        }
        jsonStream << "}";
        if (i < rows.size() - 1) {
            jsonStream << ",";
        }
    }
    
    jsonStream << "]";
    return jsonStream.str();
}

std::string DataTransformer::jsonToXml(const std::string& jsonData) {
    // Simple JSON to XML conversion (basic implementation)
    std::string xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    
    // This is a very basic implementation that would need to be enhanced
    // for real-world use with proper JSON parsing
    xml += "<data>\n";
    xml += "  <content>" + jsonData + "</content>\n";
    xml += "  <transformed>true</transformed>\n";
    xml += "  <timestamp>" + std::to_string(time(nullptr)) + "</timestamp>\n";
    xml += "</data>";
    
    return xml;
}

std::string DataTransformer::addMetadata(const std::string& jsonData) {
    std::string enhancedJson = jsonData;
    
    // Remove trailing } if present
    if (!enhancedJson.empty() && enhancedJson.back() == '}') {
        enhancedJson.pop_back();
        
        // Add metadata
        if (!enhancedJson.empty() && enhancedJson.back() == '{') {
            enhancedJson += "\"metadata\": {";
        } else {
            enhancedJson += ",\"metadata\": {";
        }
        
        enhancedJson += "\"processedBy\": \"DataTransformer\",";
        enhancedJson += "\"timestamp\": " + std::to_string(time(nullptr)) + ",";
        enhancedJson += "\"version\": \"1.0\"";
        enhancedJson += "}";
        enhancedJson += "}";
    }
    
    return enhancedJson;
}

// Global data transformer instance
static DataTransformer dataTransformer;

// JNI functions to expose to Java/Kotlin
extern "C" {

JNIEXPORT jstring JNICALL
Java_com_example_flutter_1cpp_1basic_DataTransformerWrapper_transformJson(JNIEnv *env, jobject thiz, jstring jsonInput) {
    const char *jsonStr = env->GetStringUTFChars(jsonInput, 0);
    std::string input(jsonStr);
    std::string result = dataTransformer.transformJson(input);
    env->ReleaseStringUTFChars(jsonInput, jsonStr);
    return env->NewStringUTF(result.c_str());
}

JNIEXPORT jstring JNICALL
Java_com_example_flutter_1cpp_1basic_DataTransformerWrapper_analyzeText(JNIEnv *env, jobject thiz, jstring textInput) {
    const char *textStr = env->GetStringUTFChars(textInput, 0);
    std::string input(textStr);
    std::string result = dataTransformer.analyzeText(input);
    env->ReleaseStringUTFChars(textInput, textStr);
    return env->NewStringUTF(result.c_str());
}

JNIEXPORT jstring JNICALL
Java_com_example_flutter_1cpp_1basic_DataTransformerWrapper_convertFormat(JNIEnv *env, jobject thiz, jstring dataInput, jstring fromFormat, jstring toFormat) {
    const char *dataStr = env->GetStringUTFChars(dataInput, 0);
    const char *fromStr = env->GetStringUTFChars(fromFormat, 0);
    const char *toStr = env->GetStringUTFChars(toFormat, 0);
    
    std::string data(dataStr);
    std::string from(fromStr);
    std::string to(toStr);
    std::string result = dataTransformer.convertFormat(data, from, to);
    
    env->ReleaseStringUTFChars(dataInput, dataStr);
    env->ReleaseStringUTFChars(fromFormat, fromStr);
    env->ReleaseStringUTFChars(toFormat, toStr);
    
    return env->NewStringUTF(result.c_str());
}

}