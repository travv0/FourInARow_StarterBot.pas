program FourInARow;

uses
    Classes;

var
    line, error, cmd: string;
    parsedLine: TStringList;

begin
    parsedLine:= TStringList.Create;
    parsedLine.Delimiter:= #32;

    while not eof(input) do begin
        readln(line);
        if line = '' then begin
            error:= 'No input found.';
            continue;

            parsedLine.delimitedText:= line;
            cmd:= parsedLine[0];

            if parsedLine.count = 0 then begin
                error:= error + 'Unable to parse command.';
                continue;
            end
        end;

        writeln(line);
    end;

    readln
end.
