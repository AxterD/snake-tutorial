with Ada.Text_IO;
with Ada.Wide_Wide_Text_IO;
with Ada.Characters.Conversions;

package body Noki is

   function Trim (S : String) return String is
      (S (S'First + 1 .. S'Last));

   function "+" (P : Pixel_T) return WWStr_T is
      BOLD     : constant String := CSI & "1m";
      RESET    : constant String := CSI & "0m";
      FG_Color : constant String := CSI & "38;2;" & 
                                    Trim (P.FC.R'Image) & ";" & 
                                    Trim (P.FC.G'Image) & ";" & 
                                    Trim (P.FC.B'Image) & "m"; 
      BG_Color : constant String := CSI & "48;2;" & 
                                    Trim (P.BC.R'Image) & ";" & 
                                    Trim (P.BC.G'Image) & ";" & 
                                    Trim (P.BC.B'Image) & "m";
      FORMAT   : constant String := (if P.B then 
                                       FG_Color & BG_Color & BOLD 
                                    else 
                                       FG_Color & BG_Color);
      function WWS (S : String) return WWStr_T 
         renames Ada.Characters.Conversions.To_Wide_Wide_String;
   begin
      return WWS (FORMAT) & P.C & WWS (RESET);
   end "+";

   procedure Log (S : String) is
   begin
      Ada.Text_IO.Put (S);
      Ada.Text_IO.New_Line;
   end Log;

   procedure Draw (P : Pixel_T) is
   begin
      Ada.Wide_Wide_Text_IO.Put (+P);
   end Draw;

   procedure Render (T : Texture_T; P : Pt2_T) is
      function Move_Cursor (Row : Positive; Col : Positive) return String is
         (CSI & Trim (Row'Image) & ";" & Trim (Col'Image) & "H");
      Dx : Integer := Integer (P.X);
      Dy : Integer := Integer (P.Y);
   begin
      for Y in T.First_Index .. T.Last_Index loop
         Ada.Text_IO.Put (Move_Cursor (Y + 1 + Dy, Positive'First + Dx));
         for X in T (Y).First_Index .. T (Y).Last_Index loop
            Draw (T (Y) (X));
         end loop;
      end loop;
   end Render;

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
               exit;
            when Character'Val (10) | Character'Val (32) => 
               Input_Cmd.Set (Enter);
            when others => 
               Input_Cmd.Set (Undefined);
         end case;
      end loop;
   end Input_Task_T;

end Noki;