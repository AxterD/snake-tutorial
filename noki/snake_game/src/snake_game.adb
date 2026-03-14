with GNAT.OS_Lib;

with Noki;

procedure Snake_Game is
package N renames Noki;
use N;
type GameState_T is (Welcome, Play, Game_Over, Undefined);
Game_State : GameState_T := Welcome;
N_Input_Task : Input_Task_T;

begin
loop
    exit when Input_Cmd.Get = Quit;
    Log(Clear_Screen);
    case Game_State is
        when Welcome =>
            Log("Welcome to Sankotron!");
            Log ("Press Enter/Space to play, Q/Esc to quit");
            if Input_Cmd.Get = Enter then
               Game_State := Play;
               Input_Cmd.Reset;
            end if;
        when Play =>
            Log("We are Playing!");
            Game_State := Game_Over;
        when Game_Over =>
            Log ("Game Over!");
            Log ("Press Enter/Space to replay");
            if Input_Cmd.Get = Enter then
               Game_State := Play;
               Input_Cmd.Reset;
            end if;
        when others =>
            Log("Press Ctrl+C to abort game");
    end case;
    delay 1.0;
end loop;
GNAT.OS_Lib.OS_Exit (0);
end Snake_Game;
