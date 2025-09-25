with Noki;
with Snake; use Snake;
with GNAT.OS_Lib;

procedure Snake_Game is
   package N renames Noki;
   use N;
   Input_Task : Input_Task_T;
   type Game_State_T is (Welcome, Play, Game_Over, Undefined);
   Game_State : Game_State_T := Welcome;
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
            Log ("We are playing.");
            Draw (Tongue_Pix);
            Draw (Head_Pix);
            Draw (Torso_Pix);
            Draw (Torso_Pix);
            Draw (Torso_Pix);
            Draw (Torso_Pix);
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