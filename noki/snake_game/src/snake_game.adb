with Noki;

procedure Snake_Game is
type GameState_T is (Welcome, Play, Game_Over, Undefined);
Game_State : GameState_T := Welcome;

begin
loop
      Noki.Log(Noki.Clear_Screen);
    case Game_State is
        when Welcome =>
            Noki.Log("Welcome to Sankotron!");
            Game_State := Play;
        when Play =>
            Noki.Log("We are Playing!");
            Game_State := Game_Over;
        when Game_Over =>
            Noki.Log("Game Over!");
            Game_State := Undefined;
        when others =>
            Noki.Log("Press Ctrl+C to abort game");
    end case;
    delay 1.0;
end loop;
end Snake_Game;
