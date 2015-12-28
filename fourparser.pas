unit fourparser;

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}

interface

uses
	Classes, SysUtils, fourgame;

procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
procedure ParseInput();

implementation

procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
begin
	Assert(Assigned(Strings));
	Strings.Clear;
	Strings.StrictDelimiter:= true;
	Strings.Delimiter:= Delimiter;
	Strings.DelimitedText:= Input;
end;

procedure ParseInput();
var
	line, cmd: string;
	rowNum, colNum: integer;
	parsedLine, nameList, fieldRowsList, fieldColumnsList: TStringList;
	game: TGame;
begin
	parsedLine:= TStringList.Create;
	nameList:= TStringList.Create;
	fieldRowsList:= TStringList.Create;
	fieldColumnsList:= TStringList.Create;

	try
		parsedLine.Delimiter:= #32;

		while not eof(input) do begin
			readln(line);
			if line = '' then begin
				writeln('No input found.');
				continue
			end;

			parsedLine.delimitedText:= line;

			if parsedLine.count = 0 then begin
				writeln('Unable to parse command.');
				continue
			end;

			cmd:= parsedLine[0];

			if cmd = 'settings' then begin
				if parsedLine.count = 3 then begin
					if trim(parsedLine[1]) = 'timebank' then begin
						game.settings.timebank:=
							StrToIntDef(Trim(parsedLine[2]), 0)
					end

					else if trim(parsedLine[1]) = 'time_per_move' then begin
						game.settings.timePerMove:=
							StrToIntDef(Trim(parsedLine[2]), 0)
					end

					else if trim(parsedLine[1]) = 'player_names' then begin
						Split(',', parsedLine[2], nameList);
						game.settings.playerName1:= Trim(nameList[0]);
						game.settings.playerName2:= Trim(nameList[1])
					end

					else if trim(parsedLine[1]) = 'your_bot' then begin
						game.settings.yourBot:= Trim(parsedLine[2])
					end

					else if trim(parsedLine[1]) = 'your_botid' then begin
						game.settings.yourBotId:=
							StrToIntDef(Trim(parsedLine[2]), 1)
					end

					else if trim(parsedLine[1]) = 'field_columns' then begin
						game.settings.fieldColumns:=
							StrToIntDef(Trim(parsedLine[2]), 7);
						SetLength(game.fieldArray, game.settings.fieldColumns, game.settings.fieldRows)
					end

					else if trim(parsedLine[1]) = 'field_rows' then begin
						game.settings.fieldRows:=
							StrToIntDef(Trim(parsedLine[2]), 6);
						SetLength(game.fieldArray, game.settings.fieldColumns, game.settings.fieldRows)
					end

					else writeln('Invalid command: ' + parsedLine[1]);
				end

				else begin
					writeln('Wrong number of arguments for command "' + cmd + '"');
				end;
			end

			else if cmd = 'update' then begin
				if parsedLine.count = 4 then begin
					if trim(parsedLine[1]) = 'game' then begin
						if trim(parsedLine[2]) = 'round' then begin
							game.round:= StrToIntDef(Trim(parsedLine[3]), 1)
						end

						else if trim(parsedLine[2]) = 'field' then begin
							game.field:= Trim(parsedLine[3]);

							fieldRowsList.Delimiter:= ';';
							fieldRowsList.DelimitedText:= game.field;

							for rowNum:= 0 to fieldRowsList.count - 1 do begin
								fieldColumnsList.Delimiter:= ',';
								fieldColumnsList.DelimitedText:=
									fieldRowsList[rowNum];

								for colNum:= 0 to fieldColumnsList.count - 1 do
								begin
									game.fieldArray[colNum][rowNum]:=
										StrToIntDef(fieldColumnsList[colNum], -1);
								end;
							end;
						end
					end

					else writeln('Invalid command: ' + parsedLine[1]);
				end

				else begin
					writeln('Wrong number of arguments for command "' + cmd + '"')
				end;
			end

			else if cmd = 'action' then begin
				if parsedLine.count = 3 then begin
					if trim(parsedLine[1]) = 'move' then begin
						writeln('place_disc ' + IntToStr(CalcBestColumn(game)));
						flush(Output)
					end

					else writeln('Invalid command: ' + parsedLine[1]);
				end

				else begin
					writeln('Wrong number of arguments for command "' + cmd + '"')
				end;
			end

			else if cmd = 'dump' then begin
				writeln('timebank: ' + IntToStr(game.settings.timebank));
				writeln('time_per_move: ' + IntToStr(game.settings.timePerMove));
				writeln('player_names: ' + game.settings.playerName1 + ',' + game.settings.playerName2);
				writeln('your_bot: ' + game.settings.yourBot);
				writeln('your_botid: ' + IntToStr(game.settings.yourBotId));
				writeln('field_columns: ' + IntToStr(game.settings.fieldColumns));
				writeln('field_rows: ' + IntToStr(game.settings.fieldRows));
				writeln('round: ' + IntToStr(game.round));
				writeln('field: ' + game.field);
				write('field_array: ');
				for rowNum:= 0 to game.settings.fieldRows - 1 do begin
					for colNum:= 0 to game.settings.fieldColumns - 1 do begin
						write(IntToStr(game.fieldArray[colNum][rowNum]) + ' ')
					end;
					write(sLineBreak + '             ');
				end;
			end

			else if cmd = 'exit' then begin
				break;
			end

			else writeln('Invalid command: ' + cmd);

		end;

	finally
		parsedLine.Free;
		nameList.Free;
		fieldRowsList.Free;
		fieldColumnsList.Free;
	end;
end;

end.
