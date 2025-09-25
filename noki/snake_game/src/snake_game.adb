with Noki;

procedure Snake_Game is
   type Game_State_T is (Welcome, Play, Game_Over, Undefined);
   Game_State : Game_State_T := Welcome;
begin
   loop
      Noki.Log (Noki.Clear_Screen);
      case Game_State is
         when Welcome =>
            Noki.Log ("Welcome to Snakotron!");
            Game_State := Play;
         when Play =>
            Noki.Log ("We are playing.");
            Game_State := Game_Over;
         when Game_Over =>
            Noki.Log ("Game Over!");
            Game_State := Undefined;
         when others =>
            Noki.Log ("Press Ctrl+C to abort program!");
      end case;
      delay 1.0;
   end loop;
end Snake_Game;
