with Noki;
with Snake; use Snake;
with GNAT.OS_Lib;

procedure Snake_Game is
   package N renames Noki;
   use N;
   Input_Task : Input_Task_T;
   type Game_State_T is (Welcome, Play, Game_Over, Undefined);
   Game_State : Game_State_T := Welcome;
   Player : Texture_T := [[Tongue_Pix, Head_Pix,  Empty_Pix],
                          [Empty_Pix,  Torso_Pix, Empty_Pix],
                          [Empty_Pix,  Torso_Pix, Torso_Pix]];
begin
   loop
      exit when Input_Cmd.Get = Quit;
      Log (Clear_Screen);
      case Game_State is
         when Welcome =>
            Log ("Welcome to Snakotron!");
            Log ("Press Enter/Space to play, Q/Esc to quit");
            if Input_Cmd.Get = Enter then
               Game_State := Play;
               Input_Cmd.Reset;
            end if;
         when Play =>
            Render (Player);
            Game_State := Game_Over;
         when Game_Over =>
            Log ("Game Over!");
            Log ("Press Enter/Space to replay");
            if Input_Cmd.Get = Enter then
               Game_State := Play;
               Input_Cmd.Reset;
            end if;
         when others =>
            null;
      end case;
      delay 1.0;
   end loop;
   GNAT.OS_Lib.OS_Exit (0);
end Snake_Game;