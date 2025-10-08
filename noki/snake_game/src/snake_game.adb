with Noki;
with Snake; use Snake;
with Ada.Text_IO;

procedure Snake_Game is
   package N renames Noki;
   use N;
   Input_Task : Input_Task_T;
   type Game_State_T is (Welcome, Play, Game_Over, Undefined);
   Game_State : Game_State_T := Welcome;
   Player : Snake_T;
begin
   Ada.Text_IO.Put (Hide_Cursor);
   loop
      exit when Input_Cmd.Get = Quit;
      Ada.Text_IO.Put (Clear_Screen);
      case Game_State is
         when Welcome =>
            Log ("Welcome to Snakotron!");
            Log ("Press Enter/Space to play, Q/Esc to quit");
            if Input_Cmd.Get = Enter then
               Game_State := Play;
               Input_Cmd.Reset;
            end if;
         when Play =>
            Player.Transform.Pt.X := @ + 1.0;
            Player.Transform.Pt.Y := @ + 1.0;
            Render (Player.Texture, Player.Transform.Pt);
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
      Ada.Text_IO.Flush;
      delay 1.0;
   end loop;
   Ada.Text_IO.Put (Show_Cursor);
   Ada.Text_IO.Put (Clear_Screen);
   Ada.Text_IO.Flush;
end Snake_Game;