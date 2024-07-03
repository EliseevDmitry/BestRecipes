//
//  NetworkErrors.swift
//  BestRecipes
//
//  Created by Daniil Murzin on 03.07.2024.
//

import Foundation

// Определение ошибок, которые могут возникнуть при работе с API
enum NetworkErrors: Error {
    case transportError(Error) // Ошибка транспорта, например, отсутствие интернета
    case serverError(statusCode: Int) // Ошибка сервера с указанием HTTP статуса
    case noData // Данные не получены
    case decodingError(Error) // Ошибка декодирования данных
    case serverError(statusCode: Int, message: String?) // Ошибка сервера с дополнительным сообщением
    case unexpectedError
    case apiError(Error) // Ошибка API с дополнительными данными
}
