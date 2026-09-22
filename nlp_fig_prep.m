function nlp_fig_prep (h_fig,temp_text)
% nlp_fig_prep The function prepares a figure for units in inches, generally used for pulication figures

set(0,'Units','Inches');

switch temp_text

   case 'Landscape'
      set (h_fig,'PaperOrientation','Landscape'    );
      set (h_fig,'Units',           'inches'       );
      set (h_fig,'PaperPosition',   [0 0 11 8.5]   );
      set (h_fig,'Position',        [.5 .5 11 8.5] );

   case 'Portrait'
      set (h_fig,'PaperOrientation','Portrait'     );
      set (h_fig,'Units',           'inches'       );
      set (h_fig,'PaperPosition',   [0 0 8.5 11]   );
      set (h_fig,'Position',        [.5 .5 8.5 11] );
end
