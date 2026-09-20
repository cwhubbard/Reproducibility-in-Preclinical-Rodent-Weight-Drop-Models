function [num_vectorSub, num_vectorNotSub] = parse_t_points1(str_vector)
% Parse Cody's timepoints entry from his review paper data base
%   The time points str vector varies in length
%   It has the time points of the experiment in increasing values and units
%   The parser must be able to to deal with an atribary number of inputs
%   The goal is to convert everything to a standard date number with a
%   reference as the anchor, namely: 1/1/2000 at midnight 00:00:00 am or
%   military time


% Step 1 parse str_vector into the numbers and the identifier for the
% numbers, put it in 'd'

% Is this a number or ascii letter
t1 = str2double(str_vector);   % the numbers are numbers, the strings are NaN
t2 = isnan(t1);    % 0's are numbers, 1's are strings

di = 0;
s1 = 1;
for i = 1:length(str_vector)
   if t2(i) == 1
      di = di + 1;
      d(di).type = str_vector(i);
      d(di).nums = t1(s1:i-1);
      s1 = i + 1;
   end %isnan
end %end i


% Step 2
% Parse d according to the identifiers and make datenums

refTime = datenum('01-Jan-2000 00:00:00');  % Reference time
final_time = [];
for i = 1:length(d)
   switch d(i).type
      case {'second', 'seconds'}
         cur_times = refTime+(d(i).nums./86400);
      case {'minute', 'minutes'}
         cur_times = refTime+(d(i).nums./1440);
      case {'hour', 'hours', 'hours of injury completion after 2 or 12 weeks of injuries', 'hours (based on the procedure they describe)'} 
         cur_times = refTime+(d(i).nums./24);
      case {'day', 'days', 'days (schematic shows variable time ranges)', 'days (these numbers are due to injury induction being considered as the first day)', 'days continuously'}
         cur_times = refTime+(d(i).nums);
      case {'week', 'weeks'}
         cur_times = refTime+(d(i).nums.*7);
      case {'month', 'months'}
         cur_times = refTime+(d(i).nums.*30.4167);
      case {'year', 'years'}
         cur_times = refTime+(d(i).nums.*365);
      case {"days (timepoints not well described)", "19 days other times not well characterized", "days (not well described)"}
          cur_times = refTime;

   end %switch

   final_time = [ final_time cur_times];


end   %fini
num_vectorSub = final_time-refTime;
num_vectorNotSub = final_time;