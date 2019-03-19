unit VN.History;

interface

uses
  System.Generics.Collections;

type
  IvnHistory = interface
    ['{26FC3B45-81D5-4AE8-9871-84E75295EE87}']
    // public
{$REGION 'Info'}
    function Count: integer;
    function CanForward: boolean;
    function CanBack: boolean;
    function Current: string;
{$ENDREGION}
{$REGION 'Navigation'}
    procedure Navigate(const APageName: string);
    function Forward: string;
    function Back: string;
{$ENDREGION}
  end;

  TvnHistory = class(TInterfacedObject, IvnHistory)
  private
    FHistory: TList<string>;
    FCursor: integer;
    function GetCursor: integer;
    procedure SetCursor(const Value: integer);
  protected
    procedure DoClearBeforeNavigate;
  public
    constructor Create;
    destructor Destroy; override;
{$REGION 'Info'}
    /// <summary>
    ///   ���������� ��������� � �������
    /// </summary>
    function Count: integer;
    /// <summary>
    ///   �������� �� ������� �� ��� ������?
    /// </summary>
    function CanForward: boolean;
    /// <summary>
    ///   �������� �� ��������� �� ��� �����?
    /// </summary>
    function CanBack: boolean;
    /// <summary>
    ///   ������� ������� �������
    /// </summary>
    function Current: string;
{$ENDREGION}
{$REGION 'Navigation'}
    /// <summary>
    ///   ������� �� ����� ������� �������.
    /// </summary>
    procedure Navigate(const APageName: string); virtual;
    /// <summary>
    ///   ������� �� ��� ������
    /// </summary>
    function Forward: string;
    /// <summary>
    ///   ��������� �� ��� �����
    /// </summary>
    function Back: string;
{$ENDREGION}
    /// <summary>
    ///
    /// </summary>
    property Cursor: integer read GetCursor write SetCursor;
  end;

implementation

{ TvnHistory }

function TvnHistory.Back: string;
begin
  if CanBack then
    Dec(FCursor);
  Result := Current;
end;

function TvnHistory.CanBack: boolean;
begin
  Result := Cursor > 0;
end;

function TvnHistory.CanForward: boolean;
begin
  Result := Cursor < FHistory.Count;
end;

function TvnHistory.Count: integer;
begin
  Result := FHistory.Count;
end;

constructor TvnHistory.Create;
begin
  FHistory := TList<string>.Create;
  FCursor := -1;
end;

function TvnHistory.Current: string;
begin
  if (FHistory.Count > 0) and (FCursor >= 0) and (CanForward) then
    Result := FHistory[FCursor]
  else
    Result := '';
end;

destructor TvnHistory.Destroy;
begin
  FHistory.Free;
  inherited;
end;

procedure TvnHistory.DoClearBeforeNavigate;
var
  I: integer;
begin
  if FCursor <= 0 then
    Exit;
  for I := FHistory.Count - 1 downto FCursor do
    FHistory.Delete(I);
end;

function TvnHistory.Forward: string;
begin
  if CanForward then
  begin
    Inc(FCursor);
    Result := Current;
  end
  else
    Result := '';
end;

function TvnHistory.GetCursor: integer;
begin
  Result := FCursor;
end;

procedure TvnHistory.Navigate(const APageName: string);
begin
  Inc(FCursor);
  DoClearBeforeNavigate;
  FHistory.Add(APageName);
end;

procedure TvnHistory.SetCursor(const Value: integer);
begin
  FCursor := Value;
end;

end.
