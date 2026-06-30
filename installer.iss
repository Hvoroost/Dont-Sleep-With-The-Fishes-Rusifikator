[Setup]
AppName=Don't Sleep With The Fishes - Русификатор
AppVersion=1.0
DefaultDirName={code:GetGamePath}
DirExistsWarning=no
AppendDefaultDirName=no
DisableReadyPage=yes
DisableProgramGroupPage=yes
DefaultGroupName=Don't Sleep With The Fishes Mod
OutputBaseFilename=DontSleepWithTheFishes_Russian_Setup
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern

[Files]
Source: "resources.assets"; DestDir: "{app}\DontSleepWithTheFishes_Data"; Flags: ignoreversion
Source: "sharedassets1.assets"; DestDir: "{app}\DontSleepWithTheFishes_Data"; Flags: ignoreversion
Source: "sharedassets2.assets"; DestDir: "{app}\DontSleepWithTheFishes_Data"; Flags: ignoreversion
Source: "sharedassets3.assets"; DestDir: "{app}\DontSleepWithTheFishes_Data"; Flags: ignoreversion
Source: "sharedassets4.assets"; DestDir: "{app}\DontSleepWithTheFishes_Data"; Flags: ignoreversion
Source: "sharedassets5.assets"; DestDir: "{app}\DontSleepWithTheFishes_Data"; Flags: ignoreversion

[Code]
function GetGamePath(Param: String): String;
var
  SteamPath: String;
  DetectedPath: String;
begin
  if RegQueryStringValue(HKCU, 'Software\Valve\Steam', 'SteamPath', SteamPath) then
  begin
    StringChangeEx(SteamPath, '/', '\', True);
    DetectedPath := SteamPath + '\steamapps\common\Don''t Sleep With The Fishes';
    if DirExists(DetectedPath) then
    begin
      Result := DetectedPath;
      Exit;
    end;
  end;
  
  DetectedPath := ExpandConstant('{pf32}\Steam\steamapps\common\Don''t Sleep With The Fishes');
  if DirExists(DetectedPath) then
  begin
    Result := DetectedPath;
    Exit;
  end;
  
  DetectedPath := ExpandConstant('{pf64}\Steam\steamapps\common\Don''t Sleep With The Fishes');
  if DirExists(DetectedPath) then
  begin
    Result := DetectedPath;
    Exit;
  end;

  Result := ExpandConstant('{pf}\Steam\steamapps\common\Don''t Sleep With The Fishes');
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  if CurPageID = wpSelectDir then
  begin
    if not DirExists(WizardDirValue + '\DontSleepWithTheFishes_Data') then
    begin
      if MsgBox('В указанной папке не обнаружена директория "DontSleepWithTheFishes_Data". Вы уверены, что выбрали корневую папку игры?', mbConfirmation, MB_YESNO) = IDNO then
      begin
        Result := False;
      end;
    end;
  end;
end;