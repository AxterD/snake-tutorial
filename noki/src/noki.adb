with Ada.Text_IO;

package body Noki is

procedure Log (S : String) is
begin
    Ada.Text_IO.Put(S);
    Ada.Text_IO.New_Line;
end Log;

end Noki;
