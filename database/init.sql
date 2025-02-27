CREATE TABLE account (
    account_id bigint,
    username varchar(255),
    password varchar(255),
    total_wins bigint DEFAULT 0 
    total_losses bigint DEFAULT 0 
    total_games bigint DEFAULT 0 CHECK (
        total_games >= 0
        AND total_losses >= 0
        AND total_games = total_losses + total_wins
    ),
    elo bigint DEFAULT 0,
    PRIMARY KEY (account_id)
);

CREATE TABLE game (
    game_id bigint,
    winner_id bigint,
    turn_number bigint,
    robber_location bigint,
    is_game_over boolean DEFAULT FALSE,
    PRIMARY KEY (game_id),
    FOREIGN KEY (winner_id) REFERENCES account(account_id)
);

CREATE TABLE bank_cards_remaining (
    game_id bigint,
    turn_number bigint,
    brick bigint DEFAULT 19, 
    ore bigint DEFAULT 19,
    sheep bigint DEFAULT 19,
    wheat bigint DEFAULT 19,
    wood bigint DEFAULT 19,
    year_of_plenty bigint DEFAULT 2,
    monopoly bigint DEFAULT 2,
    road_building bigint DEFAULT 2,
    victory_point bigint DEFAULT 5,
    knight bigint DEFAULT 14,
    PRIMARY KEY (game_id, turn_number),
    FOREIGN KEY (game_id) REFERENCES game(game_id),
    FOREIGN KEY (turn_number) REFERENCES game(turn_number)
);

CREATE TABLE player_state (
    account_id bigint,
    game_id bigint,
    turn_number bigint,
    ore bigint DEFAULT 0,
    sheep bigint DEFAULT 0,
    wheat bigint DEFAULT 0,
    wood bigint DEFAULT 0,
    brick bigint DEFAULT 0,
    victory_point bigint DEFAULT 0,
    knight bigint DEFAULT 0,
    monopoly bigint DEFAULT 0,
    year_of_plenty bigint DEFAULT 0,
    road_building bigint DEFAULT 0,
    num_settlements bigint DEFAULT 0,
    num_roads bigint DEFAULT 0,
    num_cities bigint DEFAULT 0,
    num_longest_continuous_road bigint DEFAULT 0,
    largest_army boolean DEFAULT FALSE,
    longest_road boolean DEFAULT FALSE,
    PRIMARY KEY (account_id, game_id, turn_number),
    FOREIGN KEY (account_id) REFERENCES account(account_id),
    FOREIGN KEY (game_id) REFERENCES game(game_id),
    FOREIGN KEY (turn_number) REFERENCES game(turn_number)
);

CREATE TABLE trade (
    trade_id bigint,
    game_id bigint,
    from_player_id bigint,
    to_player_id bigint,
    given_resource varchar(255),
    given_amount bigint,
    received_resource varchar(255),
    received_amount bigint,
    is_accepted boolean DEFAULT FALSE,
    PRIMARY KEY (trade_id),
    FOREIGN KEY (game_id) REFERENCES game(game_id),
    FOREIGN KEY (from_player_id) REFERENCES account(account_id),
    FOREIGN KEY (to_player_id) REFERENCES account(account_id)
);

CREATE TABLE game_action (
    game_id bigint,
    turn_number bigint,
    action_type varchar(255),
    PRIMARY KEY (game_id, turn_number),
    FOREIGN KEY (game_id) REFERENCES game(game_id),
    FOREIGN KEY (turn_number) REFERENCES game(turn_number)
);


