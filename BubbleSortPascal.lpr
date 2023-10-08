program BubbleSortPascal;

uses
  SysUtils, DateUtils;

procedure CalcularTempo(TempoInicio, TempoFim: TDateTime; NomeArquivo: string);

var
  ArquivoLog: TextFile;
  Duracao: Int64;
  DiretorioLog, NomeArquivoLog: string;
begin
  // Calcular a diferença em milissegundos
  Duracao := MilliSecondsBetween(TempoFim, TempoInicio);

  // Criando o caminho do diretório.
  DiretorioLog := '.\logs_dos_arquivos\';

  // Criando o diretório.
  if not DirectoryExists(DiretorioLog) then
    ForceDirectories(DiretorioLog);

  // Abrir o arquivo de log em modo de acréscimo
  NomeArquivoLog:= DiretorioLog + 'logs.txt';
  AssignFile(ArquivoLog, NomeArquivoLog);

      // Verificar se o arquivo existe
  if FileExists(NomeArquivoLog) then
    Append(ArquivoLog) // Abrir o arquivo em modo de acréscimo
  else
    ReWrite(ArquivoLog); // Criar um novo arquivo

  // Escrever o registro no arquivo
  writeln(ArquivoLog, 'Nome do arquivo: ' + NomeArquivo);
  writeln(ArquivoLog, 'Horário de início: ', FormatDateTime('dd/mm/yyyy hh:nn:ss', TempoInicio));
  writeln(ArquivoLog, 'Horário de término: ', FormatDateTime('dd/mm/yyyy hh:nn:ss', TempoFim));
  writeln(ArquivoLog, 'Tempo de execução: ', Duracao, ' milissegundos');
  writeln(ArquivoLog, '---'); // Separador entre registros

  // Fechar o arquivo de log
  CloseFile(ArquivoLog);
end;

procedure OrdenarLista(var ArrayValores: Array of Integer; n: Integer);

var
  Hold, j, Pass: Integer;
  HasSwitched: Boolean;

begin
  // Método de classificação (ordenação) por bolha propriamente dito a seguir.
  HasSwitched := true;
  Pass := 0;
  while ((Pass < n-1) and (HasSwitched = true)) do
  begin
       // Repetição mais externa controla o número de passagens.
       HasSwitched := false; // Inicialmente sem trocas na passagem.
       j := 0;
       while (j < n-Pass-1) and (j < Length(ArrayValores)) do
       begin
            // Repetição mais interna contrada cada Pass individual.
            if (ArrayValores[j] > ArrayValores[j+1]) then
            begin

                 {Caso seja verdadeiro, os elementos estão fora de ordem e é
                 necessário fazer uma troca.}
                 HasSwitched := true;
                 Hold := ArrayValores[j];
                 ArrayValores[J] := ArrayValores[j+1];
                 ArrayValores[j+1] := Hold;
            end;
            j := j + 1;
       end;
       Pass := Pass + 1;
  end;
   // Depois disso, o vetor estará ordenado.
end;

procedure GuardaListaOrdenada(var ArrayValores: Array of Integer;
  NomeArquivo: String);
var
   ArquivoSaida: TextFile;
   CaminhoPasta, NomeArquivoSaida: String;
   i: Integer;

begin
  // Criando o caminho de onde os arquivos ordenados ficarão.
  CaminhoPasta := '.\arquivos_ordenados\';

  // Criando o diretório para os arquivos ficarem.
  if not DirectoryExists(CaminhoPasta) then
    ForceDirectories(CaminhoPasta);

  // Criando o nome do arquivo a ser criado.
  NomeArquivoSaida := CaminhoPasta + '_' + NomeArquivo;

  // Atribui a variável TextFile o nome dado.
  AssignFile(ArquivoSaida, NomeArquivoSaida);

  {Se o arquivo existe, as informações são acrescentadas nele; senão é criado
  um novo.}
  if FileExists(NomeArquivoSaida) then
    Append(ArquivoSaida)
  else
    Rewrite(ArquivoSaida);

  writeln('Guardando na lista ' + NomeArquivo);
  // Escrevendo a lista no arquivo.
  i := 0;
  while (i < Length(ArrayValores)) do
  begin
      writeln(ArquivoSaida, ArrayValores[i]);
      Inc(i);
  end;
  CloseFile(ArquivoSaida);
end;

const
  CaminhoArquivo = 'D:\Documents\Estudo\Faculdade\5-Semestre\Estrutura-de-Dados\projetos\GerarArquivosComValoresAleatorios\arquivos_dos_numeros\';

var
  ArquivoInfo: TSearchRec;
  CaminhoDaPasta: string;
  ArqEntrada: TextFile;
  Contador, Controle, n: Integer;
  ArrayValores: Array of Integer;
  TempoInicio, TempoFim: TDateTime;

begin
  CaminhoDaPasta := ExpandFileName(CaminhoArquivo);
  {Inicializando o array pela primeira vez (arquivos de 100 valores) e a variá-
  vel de controle.}
  n := 100;
  SetLength(ArrayValores, n);
  Controle := 1;

  {Função que abre o diretório de arquivos inserido pelo usuário, busca arquivos
  .txt dentro deles, salva os valores contidos dentro dos arquivos em um array
  dinâmico e ordena os valores do array dentro de um segundo arquivo. Note que
  essa função seguirá um padrão específico para resolver o problema de 4 arqui-
  vos com ordenação diferente. Então, este algoritmo não é robusto para ser im-
  plementado em qualquer local. Tome cuidado ao utilizá-lo, caso queira. OBS:
  não recomendo utilizar esse código, pois fiz ele para resolver um exercício
  solicitado por meu professor e, como já fora dito, ele não foi feito para ser
  robusto.}
  if FindFirst(CaminhoDaPasta + '*.txt', faAnyFile, ArquivoInfo) = 0 then
  begin
    repeat
    // O nome do arquivo está em ArquivoInfo.Name
    AssignFile(ArqEntrada, CaminhoArquivo + ArquivoInfo.Name);
    Reset(ArqEntrada);

    { Checando a variável de controle e alocando memória segundo a lógica
    aplicada.}
    case Controle of
      4: begin
              n := 500;
         end;
      8: begin
              n := 1000;
         end;
      12: begin
               n := 5000;
          end;
      16: begin
               n := 10000;
          end;
      20: begin
               n := 50000;
          end;
      24: begin
               n := 50000;
          end;
      28: begin
               n := 100000;
          end;
      32: begin
               n := 500000;
          end;
      36: begin
               n := 1000000;
          end;
      40: begin
               n := 5000000;
          end;
      44: begin
               n := 10000000;
          end;
      48: begin
               n := 50000000;
          end;
      end;
      SetLength(ArrayValores, n);
      Inc(Controle);

      // Inicializando um contador para controle dos elementos inseridos no array
      Contador := 1;
        while not EOF(ArqEntrada) and (Contador < Length(ArrayValores))do
        begin
          // Lendo o valor do arquivo e o guardando dentro de um array;
          ReadLn(ArqEntrada, ArrayValores[Contador]);
          Inc(Contador);
        end;
      CloseFile(ArqEntrada);

      // Inicializando variável 1 para calcular o tempo levado para a ordenação.
      TempoInicio := Now;

      // Chamando o procedimento de ordenação do array.
      OrdenarLista(ArrayValores, n);

      // Inicializando variável 2 para calcular o tempo levado para a ordenação.
      TempoFim := Now;

      // Chamada de procedimento para armazenar o Array ordenado em um arquivo.
      GuardaListaOrdenada(ArrayValores, ArquivoInfo.Name);

      { Chamada de procedimento que calcula o tempo levado na ordenação e o
      armazenando em um diretório com um arquivo de logs.}
      CalcularTempo(TempoInicio, TempoFim, ArquivoInfo.Name);

      until FindNext(ArquivoInfo) <> 0;

      FindClose(ArquivoInfo);
      // Desalocando a memória para o Array;
      SetLength(ArrayValores, 0);
  end
  else
    writeln('Nenhum arquivo encontrado.');
  readln;
end.
