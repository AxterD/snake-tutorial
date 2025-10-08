with Noki; use Noki;
package Snake is
   Tongue : constant WWChar_T := '~';
   Head   : constant WWChar_T := WWChar_T'Val (16#25C0#);
   Torso  : constant WWChar_T := '◆';

   Tongue_Pix : Pixel_T := (FC => Hot_Tangerine, 
                            BC => Deep_Navy, 
                            C  => Tongue, 
                            B  => True);  
   Head_Pix   : Pixel_T := (Acid_Lime, Deep_Navy, Head, True);
   Torso_Pix  : Pixel_T := (Neon_Pink, Deep_Navy, Torso, True);

   type Snake_T is record
      Transform : Transform_T;
      Texture   : Texture_T := [[Tongue_Pix, Head_Pix,  Empty_Pix],
                                [Empty_Pix,  Torso_Pix, Empty_Pix],
                                [Empty_Pix,  Torso_Pix, Torso_Pix]];
   end record;
end Snake;
