//
//  Posts.swift
//  Navigation
//
//  Created by Iuliia Volkova on 15.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

struct allPosts {
     static let postArray = [
        PostVK(author: "Gavryusha the Cat", description: """
    Закончил аспирантуру: теперь я кот ученый!
    
    
    
    
    
    Начал замечать странные паттерны: соотношение просмотров и лайков какое-то подозрительное...
    """, image: "scientistСat", likes: 64, views: 128),
        PostVK(author: "Gavryusha the Cat", description: "Играл в монополию. Скучно, я всегда выигрываю.", image: "playingMonopoly", likes: 32, views: 64),
        PostVK(author: "Gavryusha the Cat", description: "Нарисовал шедевр. Масло плохо оттирается от лапок. В следующий раз буду использовать только акрил.", image: "myPainting", likes: 16, views: 32),
        PostVK(author: "Gavryusha the Cat", description: """
  Сегодня был очень продуктивный день: я караулил диван, чтобы он не сбежал; читал и ел сборник по функциональной стилистике; открыл все знаки вопроса на карте Скеллиге; поймал паука; передвинул всю обувь в доме, чтоб было по фэншую; приготовил пасту; посмотрел 4 сезона "Доктор Кто"; написал статью о полевом структурировании функциональной семантико-стилистической категории акцентности в политическо телеэфире; покачал пресс.
  
  И при всем при этом выглядел невероятно мило.
  """, image: "cutieMe", likes: 8, views: 16)
    ]
}
