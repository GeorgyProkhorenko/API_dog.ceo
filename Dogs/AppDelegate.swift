//
//  AppDelegate.swift
//  Dogs
//
//  Created by Прохоренко Георгий Денисович on 23.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
	// Можно удалить метод ниже
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


// Общее
// Прикрутить swiftLint https://github.com/realm/SwiftLint и прогнать 
// Разделить бизнеслогику и отображение использовать как вариант паттерн MVP
// После разделдения написать тесты на presenter и сервисы
// Классы должны быть final
// У свойств нет модификаторов доступа
// Не использовать статические методы и переменые
// Прокидывать зависимости в обхекты явно через инит
// Код должен отвечать SOLID https://habr.com/ru/company/productivity_inside/blog/505430/
// Использовать корректные имена для класов, функций, переменных https://www.swift.org/documentation/api-design-guidelines/


// Дополнительно
// 1. Добавить возможность сохранить в избраное фотографию
// 1.1 Фотография должна сохраняться в БД использовать CoreData (должно работать офлайн)
// 1.2 В tabBar https://developer.apple.com/design/human-interface-guidelines/components/navigation-and-search/tab-bars/ должно быть два раздела, первый это тот который открывается текущим ViewContreller, второй с сохраненными фотографиями
// 1.3 В сохраненных фотографиях должны быть названия пород
// 1.4 Если сохранить больше чем одну фотографию одной породы то они должны быть визуально в одном разделе сохраненнок
// 1.5 Сохранять фотографии в основном раздлее по лонгтапу через выпадающее меню
// 1.6 Новый функционал писать через MVP и покрывать тестами
