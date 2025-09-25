package Noki is
   subtype WWChar_T is Wide_Wide_Character;
   subtype WWStr_T is Wide_Wide_String;

   type U8_T is mod 2 ** 8 with Size => 8;

   type Color_T is record                 
      R, G, B : U8_T;
   end record with Size => 32;

   subtype Bold_T is Boolean;

   type Pixel_T is record
      FC : Color_T;
      BC : Color_T;
      C  : WWChar_T;
      B  : Bold_T := False;
   end record;

   Deep_Navy     : Color_T := (13, 2, 33);
   Hot_Tangerine : Color_T := (255, 122, 24);
   Acid_Lime     : Color_T := (201, 255, 0);
   Neon_Pink     : Color_T := (255, 102, 209);

   CSI : constant String := Character'Val (16#1B#) & '[';
   
   function Clear_Screen return String is 
      (CSI & "2J" & CSI & "H");

   function "+" (P : Pixel_T) return WWStr_T;
   procedure Log (S : String);
   procedure Draw (P : Pixel_T);

   type Cmd_T is (Enter, Quit, Undefined);

   protected type Input_Cmd_T is
      procedure Set (Cmd : Cmd_T);
      function Get return Cmd_T;
      procedure Reset;
   private
      Local_Cmd : Cmd_T := Undefined;
   end Input_Cmd_T;

   Input_Cmd : Input_Cmd_T;

   task type Input_Task_T;
end Noki;
