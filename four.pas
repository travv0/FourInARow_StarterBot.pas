program FourInARow;

uses
	Classes;

var
	line, error, cmd: string;
	parsedLine: TStringList;

begin
	parsedLine:= TStringList.Create;
	parsedLine.Delimiter:= #32;
	error:= '';

	while not eof(input) do begin
		readln(line);
		if line = '' then begin
			error:= error + 'No input found.' + #10;
			continue
		end;

		parsedLine.delimitedText:= line;

		if parsedLine.count = 0 then begin
			error:= error + 'Unable to parse command.' + #10;
			continue
		end;

		cmd:= parsedLine[0];

		case cmd of
			'settings':
				if parsedLine.count = 3 then begin
					// case trim(parsedLine[1]) of
					// 	'timebank':
					// end;
				end
				else begin
					writeln('Wrong number of arguments for command ' + cmd);
				end;
			'exit': break;
		end;

		writeln(line);

	end;

	writeln(error);

	// readln
end.
