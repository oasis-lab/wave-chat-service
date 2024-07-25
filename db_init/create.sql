CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    external_id VARCHAR(255) NOT NULL UNIQUE,
    external_type VARCHAR(50),
    username VARCHAR(255),
    nickname VARCHAR(255),
    gender ENUM('male', 'female', 'other'),
    age INT,
    personality_type VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE ChatMessages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    message TEXT,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY (sender_id) REFERENCES Users(user_id),FOREIGN KEY (receiver_id) REFERENCES Users(user_id)
);


CREATE TABLE ChatMatches (
    match_id INT AUTO_INCREMENT PRIMARY KEY,
    user1_id INT,
    user2_id INT,
    match_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY (user1_id) REFERENCES Users(user_id),FOREIGN KEY (user2_id) REFERENCES Users(user_id)
);

CREATE TABLE DriftBottles (
    bottle_id INT AUTO_INCREMENT PRIMARY KEY,
    creator_id INT,
    message TEXT,
    thrown_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('floating', 'picked', 'thrown_back') DEFAULT 'floating',FOREIGN KEY (creator_id) REFERENCES Users(user_id)
);


CREATE TABLE BottleResponses (
    response_id INT AUTO_INCREMENT PRIMARY KEY,
    bottle_id INT,
    responder_id INT,
    response TEXT,
    responded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY (bottle_id) REFERENCES DriftBottles(bottle_id),FOREIGN KEY (responder_id) REFERENCES Users(user_id)
);

CREATE TABLE Posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    creator_id INT,
    title VARCHAR(255),
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FOREIGN KEY (creator_id) REFERENCES Users(user_id)
);

CREATE TABLE PostReplies (
    reply_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    replier_id INT,
    reply_text TEXT,
    replied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (replier_id) REFERENCES Users(user_id)
);

CREATE TABLE Blacklist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    blocked_user_id INT,
    blocked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (blocked_user_id) REFERENCES Users(user_id)
);