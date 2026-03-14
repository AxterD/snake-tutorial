package Noki is

CSI : constant String := Character'Val (16#1B#) & '[';
function Clear_Screen return String is (CSI & "2J" & CSI & "H");

procedure Log (S : String);

type Cmd_T is (Enter, Quit, Undefined);

protected type Input_Cmd_T is
    procedure Set (Cmd: Cmd_T);
    function Get return Cmd_T;
    procedure Reset;
private
    Local_Cmd : Cmd_T := Undefined;
end Input_Cmd_T;

Input_Cmd : Input_Cmd_T;

task type Input_Task_T;

end Noki;
