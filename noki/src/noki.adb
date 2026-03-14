with Ada.Text_IO;

package body Noki is

procedure Log (S : String) is
begin
    Ada.Text_IO.Put(S);
    Ada.Text_IO.New_Line;
end Log;

protected body Input_Cmd_T is
    procedure Set (Cmd : Cmd_T) is
    begin
        Local_Cmd := Cmd;
    end Set;

    function Get return Cmd_T is (Local_Cmd);

    procedure Reset is
    begin
        Local_Cmd := Undefined;
    end Reset;

end Input_Cmd_T;

task body Input_Task_T is
    C : Character := 'X';
begin
    loop
        Ada.Text_IO.Get_Immediate (C);
        case C is
           when 'q' | Character'Val (27) =>
              Input_Cmd.Set (Quit);
           when Character'Val (10) | Character'Val (32) =>
              Input_Cmd.Set (Enter);
           when others =>
              Input_Cmd.Set (Undefined);
        end case;
    end loop;
end Input_Task_T;

end Noki;
