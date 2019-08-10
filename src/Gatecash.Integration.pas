unit Gatecash.Integration;

interface

type
{$SCOPEDENUMS ON}
  TResponse = (COMMANDFAILURE, SUCCESS, COMMANDNOTINITIALIZED, INVALIDPARAMS);
{$SCOPEDENUMS OFF}

  TResponseHelper = record helper for TResponse
    /// <summary>
    /// Retorna o valor que representa o tipo selecionado do enum.
    /// </summary>
    function ToInteger: Integer;
    /// <summary>
    /// Converte o enum para uma string de f�cil entendimento para o usu�rio.
    /// </summary>
    function ToString: string;
    /// <summary>
    /// Converte o enum para um Texto de f�cil entendimento para o usu�rio.
    /// </summary>
    function ToText: string;
  end;

function IntToResponse(Value: Integer): TResponse;

/// Inicializa��o da comunica��o com o GATECASH.
/// A aplica��o deve inicializar a comunica��o com o GATECASH antes que qualquer
/// evento de comunica��o seja enviado. A inicializa��o da comunica��o �
/// realizada apenas uma vez, quando o programa de frente de caixa �
/// inicializado.
/// Um arquivo de configura��o (gcecho.config) � utilizado para carregar par�metros.
/// Se n�o existir, um arquivo gcecho.config � gerado com valores padr�o.
/// Para finalizar a comunica��o com o GATECASH veja GATECASH_Finaliza().
/// @param CaminhoBase Caminho (path) b�sico onde GCPlug manipula arquivos auxiliares.
/// Normalmente � o caminho da aplica��o. Usar "." para pasta local,
/// ou string vazia ("") para pasta do sistema operacional.
/// @param Servidor Sugest�o de endere�o IP do servidor GATECASH. Ex.: "127.0.0.1".
/// Essa informa��o � desconsiderada se o arquivo de configura��o "gcecho.config"
/// tiver o par�metro "Address". A configura��o do arquivo � priorit�ria.
/// @param Pdv Sugest�o de n�mero do PDV que envia as mensagens.
/// Essa informa��o � desconsiderada se o arquivo de configura��o "gcecho.config"
/// tiver o par�metro "IdPdv". A configura��o do arquivo � priorit�ria.
/// @remark Ser�o gravados registros de log em arquivos gcecho#.log, onde # indica
/// o dia da semana.
/// @return 0: Sucesso ao inicializar comunica��o.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_Finaliza.
function GATECASH_InicializaEx(const CaminhoBase: string; Servidor: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Inicializa��o da comunica��o com o GATECASH.
/// A aplica��o deve inicializar a comunica��o com o GATECASH antes que qualquer
/// evento de comunica��o seja enviado. A inicializa��o da comunica��o �
/// realizada apenas uma vez, quando o programa de frente de caixa �
/// inicializado.
/// Um arquivo de configura��o (gcecho.config) � utilizado para carregar par�metros.
/// Se n�o existir, um arquivo gcecho.config � gerado com valores padr�o.
/// Para finalizar a comunica��o com o GATECASH veja GATECASH_Finaliza().
/// @param CaminhoBase Caminho (path) b�sico onde GCPlug manipula arquivos auxiliares.
/// Normalmente � o caminho da aplica��o. Usar "." para pasta local,
/// ou string vazia ("") para pasta do sistema operacional.
/// @param Servidor Sugest�o de endere�o IP do servidor GATECASH. Ex.: "127.0.0.1".
/// Essa informa��o � desconsiderada se o arquivo de configura��o "gcecho.config"
/// tiver o par�metro "Address". A configura��o do arquivo � priorit�ria.
/// @param Pdv Sugest�o de n�mero do PDV que envia as mensagens.
/// Essa informa��o � desconsiderada se o arquivo de configura��o "gcecho.config"
/// tiver o par�metro "IdPdv". A configura��o do arquivo � priorit�ria.
/// @param CaminhoLog Caminho onde ser� salvo o arquivo de log. Se esse caminho for
/// String vazia ou NULL, o caminho utilizado ser� o CaminhoBase.
/// @remark Ser�o gravados registros de log em arquivos gcecho#.log, onde # indica
/// o dia da semana.
/// @return 0: Sucesso ao inicializar comunica��o.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_Finaliza.
function GATECASH_InicializaEx2(const CaminhoBase: string; const Servidor: string; Pdv: Integer; const CaminhoLog: string)
  : Integer; stdcall; external 'GCPlug.dll';

/// Finaliza��o da comunica��o com o GATECASH.
/// A finaliza��o da comunica��o � realizada apenas uma vez, quando o programa
/// de frente de caixa � encerrado. Esta fun��o for�a o t�rmino de qualquer
/// conex�o com outros m�dulos do GATECASH. Nenhum evento de comunica��o ser�
/// enviado ap�s a finaliza��o. Para habilitar o envio de eventos de
/// comunica��o, veja GATECASH_Inicializa().
/// @return 0: Sucesso finalizar comunica��o.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_Inicializa.
function GATECASH_Finaliza(): Integer; stdcall; external 'GCPlug.dll';

/// Evento de abertura do PDV.
/// A ser executado quando um operador inicia o acesso ao PDV (quando o PDV � aberto para vendas).
/// Tamb�m deve ser executado quando ocorrer troca o operador do PDV.
/// Geralmente associado ao login do operador no sistema de frente de caixa.
/// @param Funcionario Nome do funcion�rio que abriu o caixa.
/// Se n�o dispon�vel, informar string vazia ("").
/// @param Codigo Codigo do funcion�rio que abriu o caixa.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_AbrePdvEx(const Funcionario: string; const Codigo: string): Integer; stdcall; external 'GCPlug.dll';

/// Evento de fechamento do PDV.
/// A ser executado quando o operador finaliza o acesso ao PDV
/// (quando o PDV � fechado ou colocado em pausa). Este N�O � o evento de
/// REDU��O Z, e o caixa pode ser aberto novamente (ver GATECASH_AbrePdv).
/// Geralmente associado ao logout do operador do sistema de frente de caixa.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_AbrePdv.
function GATECASH_FechaPdv(): Integer; stdcall; external 'GCPlug.dll';

/// Informa��o de operador.
/// Adicionada em 201710 para manter mais consistente as informa��es de operador no sistema.
/// @param Funcionario Nome do funcion�rio que abriu o caixa.
/// @param Codigo Codigo do funcion�rio que abriu o caixa. Se n�o dispon�vel, informar string vazia.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_InformaOperador(const Funcionario: string; const Codigo: string): Integer; stdcall; external 'GCPlug.dll';

/// Registro de suprimento de caixa.
/// A ser executado quando o processo de suprimento de caixa � iniciado.
/// @param FormaPagamento String com nome da forma do suprimento de caixa.
/// @param Complemento Descri��o complementar da opera��o realizada.
/// Se n�o utilizado, informar string vazia ("").
/// @param Valor Valor do suprimento (adicionado ao caixa).
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_Suprimento(const FormaPagamento: string; const Complemento: string; Valor: Double): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de sangria do caixa.
/// A ser executado quando o processo de sangria do caixa � iniciado.
/// @param Complemento Descri��o complementar da opera��o realizada.
/// Se n�o utilizado, informar string vazia ("").
/// @param Valor Valor da sangria (retirado do caixa).
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_Sangria(const Complemento: string; Valor: Double): Integer; stdcall; external 'GCPlug.dll';

/// Registro de opera��o gen�rica no PDV.
/// A ser executado quando forem realizadas opera��es gen�ricas no PDV n�o associadas
/// a um cupom. Por exemplo, opera��es n�o-fiscais, leitura x, redu��o z, etc.
/// @param Operacao Nome da opera��o realizada.
/// @param Complemento Descri��o complementar da opera��o realizada.
/// Se n�o utilizado, informar string vazia ("").
/// @param Valor Valor associado � opera��o. Se n�o aplic�vel, utilizar zero.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_Operacao(const Operacao: string; const Complemento: string; Valor: Double): Integer; stdcall;
  external 'GCPlug.dll';

/// Informa que gaveta foi aberta ou fechada.
/// A ser executado no instante em que a gaveta � acionada para abertura.
/// A execu��o deste comando � opcional quando for detectado o fechamento da gaveta.
/// @param Aberta Indica se � um evento de abertura da gaveta (1) ou fechamento da gaveta (0).
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_Gaveta(Aberta: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de abertura de cupom.
/// A ser executado quando o comando de abertura de cupom � registrado.
/// Cupom � finalizado pelo comando GATECASH_FechaDocumento().
/// @param Codigo Identificador num�rico do cupom. Em geral, COO ou CNF.
/// Se n�o dispon�vel, informar -1.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_FechaDocumento.
function GATECASH_AbreCupom(Codigo: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de abertura de documento gen�rico.
/// A ser executado quando for registrada a abertura de um documento (exceto cupom fiscal).
/// Alguns documentos gen�ricos s�o: cupom n�o fiscal, relat�rio gerencial, etc.
/// Um documento gen�rico � finalizado pelo comando GATECASH_FechaDocumento().
/// Em caso de documento instant�neo (sem dura��o vari�vel), recomenda-se utilizar o comando
/// GATECASH_Operacao().
/// @param Nome String com nome do documento gen�rico aberto.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_Operacao()
/// @sa GATECASH_FechaDocumento.
function GATECASH_AbreDocumento(const Nome: string): Integer; stdcall; external 'GCPlug.dll';

/// Fechamento de cupom ou documento.
/// A ser executado quando o cupom fiscal ou um documento gen�rico for finalizado.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_AbreCupom, GATECASH_AbreDocumento.
function GATECASH_FechaDocumento(): Integer; stdcall; external 'GCPlug.dll';

/// Fechamento de cupom ou documento.
/// A ser executado quando o cupom fiscal ou um documento gen�rico for finalizado.
/// @param Codigo - o c�digo do documento que est� sendo fechado.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_AbreCupom, GATECASH_AbreDocumento.
function GATECASH_FechaDocumentoCod(Codigo: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro do cancelamento de um cupom arbitr�rio.
/// A ser executado quando o cancelamento do cupom � efetivado.
/// @param Codigo Identificador num�rico do cupom. Em geral, COO ou CNF.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_CancelandoCupom.
function GATECASH_CancelaCupomEx(Codigo: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro da anula��o de uma venda j� fechada.
/// @param Pdv Identificador do PDV no qual foi realizada a venda anteriormente.
/// @param Codigo Identificador num�rico do cupom. Em geral, COO ou CNF.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_AnulaCupom(Pdv: Integer; Codigo: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Associa informa��o de cliente ao cupom.
/// Deve ser executado enquanto o cupom est� aberto e informa o cliente que realiza a compra.
/// Geralmente executado logo ap�s a abertura do cupom ou pouco antes do seu fechamento.
/// @param Cliente String com nome do cliente ou string com n�mero que o identifica (RG, CPF, etc).
/// @param Codigo String com o c�digo do cliente.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_InformaClienteEx(const Cliente: string; const Codigo: string): Integer; stdcall; external 'GCPlug.dll';

/// Associa informa��o de Supervisor ao cupom (quem aprovou alguma opera��o que necessitava aprova��o).
/// @param Supervisor � o identificador do supervisor que aprovou a opera��o.
/// @param Codigo � o c�digo do supervisor que aprovou a opera��o.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_InformaSupervisor(const Supervisor: string; const Codigo: string): Integer; stdcall; external 'GCPlug.dll';

/// Registro de acr�scimo ou desconto ao valor total do cupom.
/// A ser executado quando algum acr�scimo ou desconto ao valor total do cupom �
/// impresso. Este registro normalmente � associado ao in�cio do fechamento do
/// cupom, ou seja, depois do �ltimo item vendido e antes do registro da
/// primeira forma de pagamento. O registro de diferen�a no cupom n�o �
/// necess�rio caso n�o haja acr�scimo ou desconto ao valor total do cupom.
/// A especifica��o de diferen�a do cupom N�O � acumulativa.
/// Ser� considerada apenas a �ltima chamada de GATECASH_DiferencaCupom() para cada cupom.
/// @param Diferenca Acr�scimo (positivo) ou desconto (negativo) no valor total do cupom.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_DiferencaCupom(Diferenca: Double): Integer; stdcall; external 'GCPlug.dll';

/// Registro de venda de item diferencia��o se � unit�rio e se foi digitado...
/// A ser executado quando a venda de item (com ou sem desconto) � registrada.
/// Se o item tiver acr�scimo ou desconto, esta diferen�a de valor deve ser informada chamando
/// GATECASH_DiferencaItem() logo ap�s o registro do item, informando o valor de acr�scimo/desconto.
/// @param Sequencia �ndice da seq��ncia do item vendido no cupom. � o mesmo �ndice que ser�
/// utilizado como refer�ncia para registro de diferen�a de item, cancelamento de item, etc.
/// @param Codigo String com c�digo do produto vendido (c�digo de barras).
/// @param Descricao String com descri��o do produto vendido.
/// @param Quantidade Quantidade da venda do produto.
/// @param ValorUnitario Valor unit�rio do produto.
/// Valor da venda � calculado por Quantidade X ValorUnit�rio.
/// @param Unitario flag que indica se o item � unit�rio ou � um item que possui venda por peso.
/// @param Scaneado flag que indica se o item foi escaneado ou digitado.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_DiferencaItem.
function GATECASH_VendeItemEx(Sequencia: Integer; const Codigo: string; const Descricao: string;
  Quantidade: Double; ValorUnitario: Double; Unitario: Boolean; Escaneado: Boolean): Integer; stdcall; external 'GCPlug.dll';

/// Registro de venda de item com diferencia��o se � unit�rio e se foi digitado..
/// Esse registro de venda de item deve ser utilizado apenas para itens fora do padr�o (como, por exemplo, itens que s�o
/// escaneados com scanner de m�o. Itens registrados com scanners de mesa ou digitados devem ser registrados com os m�todos
/// VendeItem e VendeItemEx.
/// Se o item tiver acr�scimo ou desconto, esta diferen�a de valor deve ser informada chamando
/// GATECASH_DiferencaItem() logo ap�s o registro do item, informando o valor de acr�scimo/desconto.
/// @param Sequencia �ndice da seq��ncia do item vendido no cupom. � o mesmo �ndice que ser�
/// utilizado como refer�ncia para registro de diferen�a de item, cancelamento de item, etc.
/// @param Codigo String com c�digo do produto vendido (c�digo de barras).
/// @param Descricao String com descri��o do produto vendido.
/// @param Quantidade Quantidade da venda do produto.
/// @param ValorUnitario Valor unit�rio do produto.
/// Valor da venda � calculado por Quantidade X ValorUnit�rio.
/// @param Unitario flag que indica se o item � unit�rio ou � um item que possui venda por peso.
/// @param Scaneado flag que indica se o item foi escaneado ou digitado.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_DiferencaItem.
function GATECASH_VendeItemFp(Sequencia: Integer; const Codigo: string; const Descricao: string;
  Quantidade: Double; ValorUnitario: Double; Unitario: Boolean; Escaneado: Boolean; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Consulta de pre�o de produto.
/// A ser executado quando for feita a consulta de pre�o de um produto,
/// independente de haver um cupom aberto ou n�o.
/// @param Codigo String com c�digo do produto consultado.
/// @param Descricao String com descri��o do produto consultado.
/// @param ValorUnitario Valor unit�rio do produto.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_ConsultaProduto(const Codigo: string; const Descricao: string; Valor: Double; Unitario: Boolean): Integer;
  stdcall; external 'GCPlug.dll';

/// Registro do cancelamento de item.
/// A ser executado quando o cancelamento de item � registrado (quando � efetivado).
/// @param Sequencia �ndice do item que foi cancelado.
/// Ex.: 1 indica o primeiro item do cupom. Se -1, indica �ltimo item vendido.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_CancelaItem(Sequencia: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de acr�scimo ou desconto a uma venda de item.
/// A ser executado ao registrar acr�scimo ou desconto � venda de um item.
/// Em geral � executado imediatamente ap�s GATECASH_VendeItem,
/// registrando a diferen�a lan�ada no item vendido. A diferen�a lan�ada por
/// GATECASH_DiferencaItem() N�O � acumulativa. O registro de diferen�a no item n�o �
/// necess�rio caso n�o haja acr�scimo ou desconto ao valor do item vendido.
/// @param Sequencia �ndice do item referente ao acr�scimo/desconto.
/// Ex.: 1 indica o primeiro item do cupom. Se -1, indica o �ltimo item vendido.
/// @param Diferenca Valor absoludo de acr�scimo (positivo) ou desconto (negativo)
/// no valor da venda do item.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_VendeItem.
function GATECASH_DiferencaItem(Sequencia: Integer; Diferenca: Double): Integer; stdcall; external 'GCPlug.dll';

/// Registro de acr�scimo ou desconto a uma venda de item.
/// A ser executado ao registrar acr�scimo ou desconto � venda de um item.
/// Em geral � executado imediatamente ap�s GATECASH_VendeItem,
/// registrando a diferen�a lan�ada no item vendido. A diferen�a lan�ada por
/// GATECASH_DiferencaItem() N�O � acumulativa. O registro de diferen�a no item n�o �
/// necess�rio caso n�o haja acr�scimo ou desconto ao valor do item vendido.
/// @param Sequencia �ndice do item referente ao acr�scimo/desconto.
/// Ex.: 1 indica o primeiro item do cupom. Se -1, indica o �ltimo item vendido.
/// @param Diferenca Valor absoludo de acr�scimo (positivo) ou desconto (negativo)
/// no valor da venda do item.
/// @param Motivo � a raz�o do desconto.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_VendeItem.
function GATECASH_DiferencaItemEx(Sequencia: Integer; Diferenca: Double; const Motivo: string): Integer; stdcall;
  external 'GCPlug.dll';

/// Informa desmagnetiza��o de etiqueta magn�tica durante um cupom ou documento.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_Desmagnetizacao(): Integer; stdcall; external 'GCPlug.dll';

/// Registro de forma de pagamento.
/// A ser executado quando uma forma de pagamento for registrada.
/// @param FormaPagamento String com nome da forma de pagamento.
/// @param Valor Valor pago atrav�s da forma de pagamento.
/// @param Complemento Informa��o adicional associada ao pagamento. Ex.: N�mero do cart�o.
/// Se n�o dispon�vel, informar string vazia ("").
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_FormaPagamento(const FormaPagamento: string; const Complemento: string; Valor: Double): Integer; stdcall;
  external 'GCPlug.dll';

/// Cancelamento de registro de forma de pagamento.
/// A ser executado quando for registrado o estorno de uma forma de pagamento.
/// Em geral, o valor estornado de uma forma de pagamento � movido para ser registrado em outra
/// forma de pagamento. Neste caso, um cancelamento de pagamento deve ser seguido de um novo
/// comando de forma de pagamento GATECASH_FormaPamento() com o mesmo valor estornado.
/// @param FormaPagamento String com nome da forma de pagamento cancelada.
/// @param Valor Valor cancelado da forma de pagamento.
/// N�o negativar o valor cancelado. Ex.: se estornado R$10, informar 10.
/// @param Complemento Informa��o adicional associada ao cancelamento.
/// Se n�o dispon�vel, informar string vazia ("").
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_CancelaPagamento(const FormaPagamento: string; const Complemento: string; Valor: Double): Integer; stdcall;
  external 'GCPlug.dll';

/// Informacao de erro gen�rico do sistema.
/// Informa��es como o	Erro de comunica��o com impressora, fim de papel, enfim, qualquer erro.
/// @param CodigoErro string que define o c�digo do erro
/// @param NomeErro string que define o nome do erro
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando
function GATECASH_ErroGenerico(const CodigoErro: string; const NomeErro: string): Integer; stdcall; external 'GCPlug.dll';

/// Informacao de Alerta gen�rico do sistema
/// Alertas como pouco papel em impressora, inatividade, etc podem ser registrados por esse alerta.
/// @param CodigoAlerta string que define o c�digo do Alerta
/// @param NomeAlerta string que define o nome do Alerta
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando
function GATECASH_AlertaGenerico(const CodigoAlerta: string; const NomeAlerta: string): Integer; stdcall; external 'GCPlug.dll';

/// Informacao de Ocorr�ncia gen�rica.
/// Ocorr�ncias como pedido de ajuda de cliente, Terminal inativo, etc podem ser registrados por esta mensagem.
/// @param CodigoOcorrencia string que define o c�digo da Ocorrencia
/// @param NomeOcorrencia string que define o nome da Ocorrencia
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando
function GATECASH_OcorrenciaGenerico(const CodigoOcorrencia: string; const NomeOcorrencia: string): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de abertura de transfer�ncia de mercadoria
/// Deve ser executada quando uma opera��o de transfer�ncia de mercadoria tem in�cio
/// Uma abertura de transfer�ncia � finalizada pelo comando GATECASH_FechaTransfer�ncia().
/// @param Identificador String identificando o processo de transfer�ncia
/// @param NomeLocal String identificando o local da transfer�ncia
/// @param DataEmissao Data de emiss�o da nota fiscal ou pedido
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunica��o n�o inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_SuspendeTransferencia
/// @sa GATECASH_FechaTransferencia
function GATECASH_AbreTransferencia(const Identificador: string; const NomeLocal: string; DataEmissao: TDate): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de nota fiscal.
/// Alguns casos de sistema de recebimento podem ter mais de uma nota fiscal vinculada, por isso a cria��o dessa fun��o.
/// @param Identificador String identificando o processo de transfer�ncia
/// @param Serie String identificando S�rie no processo de transfer�ncia
/// @param DataEmissao data emiss�o da nota
/// @param Entrada booleano que indica se � entrada (true) ou sa�da (false)
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunica��o n�o inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_AbreTransferencia
function GATECASH_InformaNF(const Identificador: string; const Serie: string; DataEmissao: TDate; Entrada: Boolean): Integer;
  stdcall; external 'GCPlug.dll';

/// Registro de suspens�o de transfer�ncia de mercadoria
/// Deve ser executada quando uma opera��o de transfer�ncia de mercadoria � interrompida por algum motivo
/// Uma transfer�ncia pode ser retomada pelo comando GATECASH_RetomaTransferencia().
/// @param Identificador String identificando o processo de transfer�ncia
/// @param Motivo String identificando o motivo da suspens�o da transfer�ncia
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunica��o n�o inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_RetomaTransferencia
function GATECASH_SuspendeTransferencia(const Identificador: string; const Motivo: string): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de retomada de transfer�ncia de mercadoria
/// Deve ser executada quando uma opera��o de transfer�ncia de mercadoria estava interrompida e foi retomada
/// Uma transfer�ncia pode ser suspendida pelo comando GATECASH_SuspendeTransferencia().
/// @param Identificador String identificando o processo de transfer�ncia
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunica��o n�o inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_SuspendeTransferencia
function GATECASH_RetomaTransferencia(const Identificador: string): Integer; stdcall; external 'GCPlug.dll';

/// Registro de cancelamento de transfer�ncia de mercadoria
/// Deve ser executada quando uma opera��o de transfer�ncia de mercadoria � cancelada antes de ser conclu�da
/// Impossibilita qualquer a��o posterior vinculada a essa transfer�ncia
/// @param Identificador String identificando o processo de transfer�ncia
/// @param Motivo String identificando o motivo do cancelamento da transfer�ncia
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunica��o n�o inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_AbreTransferencia
/// @sa GATECASH_FechaTransferencia
function GATECASH_CancelaTransferencia(const Identificador: string; const Motivo: string): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de fechamento de transfer�ncia de mercadoria
/// Deve ser executada quando uma opera��o de transfer�ncia de mercadoria � conclu�da com sucesso
/// Impossibilita qualquer a��o posterior vinculada a essa transfer�ncia
/// @param Identificador String identificando o processo de transfer�ncia
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunica��o n�o inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_AbreTransferencia
/// @sa GATECASH_CancelaTransferencia
function GATECASH_FechaTransferencia(const Identificador: string): Integer; stdcall; external 'GCPlug.dll';

/// Registro do tipo de transfer�ncia que est� sendo realizada
/// Deve ser executada ap�s a abertura de uma transfer�ncia
/// � vinculada � transfer�ncia atualmente ativa
/// @param Tipo inteiro que informa a natureza da transfer�ncia: 1 - Recebimento; 2 - Devolu��o; 3 - Sa�da; 4 - Outros
/// @param Descricao usado para informar o nome caso seja a transfer�ncia seja do tipo outros
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunica��o n�o inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_InformaConferente
/// @sa GATECASH_InformaFornecedor
function GATECASH_InformaTipoTransferencia(Tipo: Integer; const Descricao: string): Integer; stdcall; external 'GCPlug.dll';

/// Registro do funcion�rio que est� conferindo a transfer�ncia
/// Deve ser executada ap�s a abertura de uma transfer�ncia
/// � vinculada � transfer�ncia atualmente ativa
/// @param Identificador C�digo do conferente que est� realizando a transfer�ncia
/// @param Nome Nome do conferente que est� realizando a transfer�ncia
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunica��o n�o inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_InformaTipoTransferencia
/// @sa GATECASH_InformaFornecedor
function GATECASH_InformaConferente(const Identificador: string; const Nome: string): Integer; stdcall; external 'GCPlug.dll';

/// Registro do fornecedor da transfer�ncia
/// Deve ser executada ap�s a abertura de uma transfer�ncia
/// � vinculada � transfer�ncia atualmente ativa
/// @param Identificador C�digo do fornecedor atribu�do � transfer�ncia
/// @param Nome Nome do fornecedor atribu�do � transfer�ncia
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunica��o n�o inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_InformaTipoTransferencia
/// @sa GATECASH_InformaConferente
function GATECASH_InformaFornecedor(const Identificador: string; const Nome: string): Integer; stdcall; external 'GCPlug.dll';

/// Registro de sa�da de ve�culo
/// Deve ser executado apenas em uma transfer�ncia do tipo sa�da
/// @param Placa Placa associada ao ve�culo de transporte
/// @param TipoVeiculo Nome associado ao ve�culo de transporte
/// @param CodigoMotorista Identificador que pode ser CPF, RG ou CNH
/// @param NomeMotorista Nome do Condutor
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_InformaFornecedor
/// @sa GATECASH_InformaTipoTransferencia
function GATECASH_InformaSaidaVeiculo(const Placa: string; const TipoVeiculo: string;
  const CodigoMotorista: string; const NomeMotorista: string): Integer; stdcall; external 'GCPlug.dll';

/// Sinaliza o in�cio de uma contagem ou recontagem
/// Deve ser executada ap�s a abertura de uma transfer�ncia e antes de iniciar a transfer�ncia de itens
/// � vinculada � transfer�ncia atualmente ativa
/// @param Tipo Usado para identificar se os itens que ser�o transferidos pertencem a uma contagem (1) ou recontagem (2)
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunica��o n�o inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_InformaTipoTransferencia
/// @sa GATECASH_InformaConferente
function GATECASH_RegistraContagem(Tipo: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de transfer�ncia de item.
/// Deve ser executada ap�s um registro de contagem e antes do fechamento de transfer�ncia de itens
/// @param Sequencia �ndice da sequ�ncia do item transferido. � o mesmo �ndice que ser�
/// utilizado como refer�ncia para cancelamento de item
/// @param Codigo String com c�digo do produto transferido (normalmente c�digo de barras).
/// @param Descricao String com descri��o do produto transferido.
/// @param NomeTipoEmbalagem String com nome associado ao tipo de embalagem, i.e. pallet, caixa, fardo, ...
/// @param QuantidadeEmbalagem Quantidade de embalagem na transfer�ncia
/// @param QuantidadeItem Quantidade total de itens na transfer�ncia
/// @param Validade Validade do lote de itens transferidos
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_RegistraContagem
/// @sa GATECASH_CancelaItemTransferencia
function GATECASH_TransfereItem(Sequencia: Integer; const Codigo: string; const Descricao: string;
  const Nome: string; TipoEmbalagem, QuantidadeEmbalagem: Integer;
  QuantidadeItem: Double; Validade: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de cancelamento de um item da transfer�ncia.
/// Deve ser executada ap�s um registro de contagem e antes do fechamento de transfer�ncia de itens
/// @param Sequencia �ndice da sequ�ncia do item transferido a ser cancelado
/// @param QuantidadeItem Quantidade de itens que foram cancelados
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_RegistraContagem
/// @sa GATECASH_TransfereItem
function GATECASH_CancelaItemTransferencia(Sequencia: Integer; QuantidadeItem: Double): Integer; stdcall; external 'GCPlug.dll';

//* *********** METHODS THAT INFORM MULTIPLES PDVS IN ONE INSTANCE OF GATECASH ******* *//
//* ******************** OPERATION EQUALS THE ABOVE FUNCTIONS **************** ******* *//
/// Evento de abertura de um determinado pdv.
function GATECASH_AbrePdvEx_InformPDV(const Funcionario: string; const Codigo: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Evento de fechamento de um determinado PDV.
function GATECASH_FechaPdv_InformPDV(Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Informa��o de operador de um determinado pdv.
function GATECASH_InformaOperador_InformPDV(const Funcionario: string; const Codigo: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de suprimento de caixa de um determinado pdv.
function GATECASH_Suprimento_InformPDV(const FormaPagamento: string; const Complemento: string; Valor: Double; Pdv: Integer)
  : Integer; stdcall; external 'GCPlug.dll';

/// Registro de sangria do caixa de um determinado pdv.
function GATECASH_Sangria_InformPDV(const Complemento: string; Valor: Double; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de opera��o gen�rica de um determinado pdv.
function GATECASH_Operacao_InformPDV(const Operacao: string; const Complemento: string; Valor: Double; Pdv: Integer): Integer;
  stdcall; external 'GCPlug.dll';

/// Informa que gaveta foi aberta ou fechada de um determinado pdv.
function GATECASH_Gaveta_InformPDV(Aberta: Integer; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de abertura de cupom de um determinado pdv.
function GATECASH_AbreCupom_InformPDV(Codigo: Integer; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de abertura de documento gen�rico de um determinado pdv.
function GATECASH_AbreDocumento_InformPDV(const Nome: string; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Fechamento de cupom ou documento de um determinado pdv.
function GATECASH_FechaDocumento_InformPDV(Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Fechamento de cupom ou documento de um determinado pdv.
function GATECASH_FechaDocumentoCod_InformPDV(Codigo: Integer; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro do cancelamento de um cupom arbitr�rio de um determinado pdv.
function GATECASH_CancelaCupomEx_InformPDV(Codigo: Integer; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro da anula��o de uma venda j� fechada de um determinado pdv.
function GATECASH_AnulaCupom_InformPDV(Pdv: Integer; Codigo: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Associa informa��o de cliente ao cupom de um determinado pdv.
function GATECASH_InformaClienteEx_InformPDV(const Cliente: string; const Codigo: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Associa informa��o de Supervisor ao cupom (quem aprovou alguma opera��o que necessitava aprova��o) de um determinado pdv.
function GATECASH_InformaSupervisor_InformPDV(const Supervisor: string; const Codigo: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de acr�scimo ou desconto ao valor total do cupom de um determinado pdv.
function GATECASH_DiferencaCupom_InformPDV(Diferenca: Double; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de venda de item diferencia��o se � unit�rio e se foi digitado...de um determinado pdv
function GATECASH_VendeItemEx_InformPDV(Sequencia: Integer; const Codigo: string; const Descricao: string;
  Quantidade: Double; ValorUnitario: Double; Unitario: Boolean; Escaneado: Boolean; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de venda de item com diferencia��o se � unit�rio e se foi digitado.. de um determinado pdv
function GATECASH_VendeItemFp_InformPDV(Sequencia: Integer; const Codigo: string; const Descricao: string;
  Quantidade: Double; ValorUnitario: Double; Unitario: Boolean; Escaneado: Boolean; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Consulta de pre�o de produto de um determinado pdv.
function GATECASH_ConsultaProduto_InformPDV(const Codigo: string; const Descricao: string; ValorUnitario: Double; Pdv: Integer)
  : Integer; stdcall; external 'GCPlug.dll';

/// Registro do cancelamento de item de um determinado pdv.
function GATECASH_CancelaItem_InformPDV(Sequencia: Integer; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de acr�scimo ou desconto a uma venda de item de um determinado pdv.
function GATECASH_DiferencaItem_InformPDV(Sequencia: Integer; Diferenca: Double; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de acr�scimo ou desconto a uma venda de item de um determinado pdv.
function GATECASH_DiferencaItemEx_InformPDV(Sequencia: Integer; Diferenca: Double; const Motivo: string; Pdv: Integer): Integer;
  stdcall; external 'GCPlug.dll';

/// Informa desmagnetiza��o de etiqueta magn�tica durante um cupom ou documento de um determinado pdv.
function GATECASH_Desmagnetizacao_InformPDV(Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de forma de pagamento de um determinado pdv.
function GATECASH_FormaPagamento_InformPDV(const FormaPagamento: string; const Complemento: string; Valor: Double; Pdv: Integer)
  : Integer; stdcall; external 'GCPlug.dll';

/// Cancelamento de registro de forma de pagamento de um determinado pdv.
function GATECASH_CancelaPagamento_InformPDV(const FormaPagamento: string; const Complemento: string; Valor: Double; Pdv: Integer)
  : Integer; stdcall; external 'GCPlug.dll';

/// Informacao de erro gen�rico do sistema de um determinado pdv.
function GATECASH_ErroGenerico_InformPDV(const CodigoErro: string; const NomeErro: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Informacao de Alerta gen�rico do sistema de um determinado pdv
function GATECASH_AlertaGenerico_InformPDV(const CodigoAlerta: string; const NomeAlerta: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Informacao de Ocorr�ncia gen�rica de um determinado pdv.
function GATECASH_OcorrenciaGenerico_InformPDV(const CodigoOcorrencia: string; const NomeOcorrencia: string; Pdv: Integer)
  : Integer; stdcall; external 'GCPlug.dll';

/// Registro de abertura de transfer�ncia de mercadoria de um determinado pdv
function GATECASH_AbreTransferencia_InformPDV(const Identificador: string; const NomeLocal: string; DataEmissao: TDate;
  Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de suspens�o de transfer�ncia de mercadoria de um determinado pdv
function GATECASH_SuspendeTransferencia_InformPDV(const Identificador: string; const Motivo: string; Pdv: Integer): Integer;
  stdcall; external 'GCPlug.dll';

/// Registro de retomada de transfer�ncia de mercadoria de um determinado pdv
function GATECASH_RetomaTransferencia_InformPDV(const Identificador: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de cancelamento de transfer�ncia de mercadoria de um determinado pdv
function GATECASH_CancelaTransferencia_InformPDV(const Identificador: string; const Motivo: string; Pdv: Integer): Integer;
  stdcall; external 'GCPlug.dll';

/// Registro de fechamento de transfer�ncia de mercadoria de um determinado pdv
function GATECASH_FechaTransferencia_InformPDV(const Identificador: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro do tipo de transfer�ncia que est� sendo realizada de um determinado pdv
function GATECASH_InformaTipoTransferencia_InformPDV(Tipo: Integer; const Descricao: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro do funcion�rio que est� conferindo a transfer�ncia de um determinado pdv
function GATECASH_InformaConferente_InformPDV(const Identificador: string; const Nome: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro do fornecedor da transfer�ncia de um determinado pdv
function GATECASH_InformaFornecedor_InformPDV(const Identificador: string; const Nome: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de sa�da de ve�culo de um determinado pdv
function GATECASH_InformaSaidaVeiculo_InformPDV(const Placa: string; const TipoVeiculo: string;
  const CodigoMotorista: string; const NomeMotorista: string; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Sinaliza o in�cio de uma contagem ou recontagem de um determinado pdv
function GATECASH_RegistraContagem_InformPDV(Tipo: Integer; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de transfer�ncia de item de um determinado pdv.
function GATECASH_TransfereItem_InformPDV(Sequencia: Integer; const Codigo: string; const Descricao: string;
  const NomeTipoEmbalagem: string; QuantidadeEmbalagem: Integer;
  QuantidadeItem: Double; Validade: Integer; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de cancelamento de um item da transfer�ncia de um determinado pdv.
function GATECASH_CancelaItemTransferencia_InformPDV(Sequencia: Integer; QuantidadeItem: Double; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de informa��o de nota fiscal.
function GATECASH_InformaNF_InformPDV(const Identificador: string; const Serie: string; DataEmissao: TDate; Entrada: Boolean;
  Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

//* ****************************** DEPRECATED METHODS ******************************** *//

/// Inicializa��o da comunica��o com o GATECASH (simplificado).
/// Equivale a executar GATECASH_InicializaEx() sem informar Servidor e Pdv.
/// Veja documenta��o de GATECASH_InicializaEx() para mais informa��es.
/// @param CaminhoBase Caminho (path) b�sico onde GCPlug manipula arquivos auxiliares.
/// @return 0: Sucesso ao inicializar comunica��o.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_InicializaEx.
/// @sa GATECASH_Finaliza.
/// @remark Servidor e Pdv devem estar especificados no arquivo de configura��o.
function GATECASH_Inicializa(const CaminhoBase: string): Integer; stdcall; external 'GCPlug.dll';

/// Evento de abertura do PDV.
/// A ser executado quando um operador inicia o acesso ao PDV (quando o PDV � aberto para vendas).
/// Tamb�m deve ser executado quando ocorrer troca o operador do PDV.
/// Geralmente associado ao login do operador no sistema de frente de caixa.
/// @param Funcionario Nome do funcion�rio que abriu o caixa.
/// Se n�o dispon�vel, informar string vazia ("").
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_AbrePdv(const Funcionario: string): Integer; stdcall; external 'GCPlug.dll';

/// Associa informa��o de cliente ao cupom.
/// Deve ser executado enquanto o cupom est� aberto e informa o cliente que realiza a compra.
/// Geralmente executado logo ap�s a abertura do cupom ou pouco antes do seu fechamento.
/// @param Cliente String com nome do cliente ou string com n�mero que o identifica (RG, CPF, etc).
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_InformaCliente(const Cliente: string): Integer; stdcall; external 'GCPlug.dll';

/// In�cio do cancelamento do �ltimo cupom.
/// A ser executado quando o processo de cancelamento de cupom � iniciado.
/// Em geral, quando o operador de caixa solicita a presen�a do supervisor para cancelar o cupom.
/// O cancelamento refere-se ao �ltimo cupom registrado, que pode j� ter sido conclu�do ou n�o.
/// Este comando � opcional, pois em muitos sistemas de frente de caixa o "in�cio de cancelamento"
/// n�o passa pelo sistema.
/// Independente de executar GATECASH_CancelandoCupom(), o comando GATECASH_CancelaCupom()
/// dever� ser executado quando o cancelamento do cupom for efetivado (enviado � impressora).
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_CancelaCupom.
function GATECASH_CancelandoCupom(): Integer; stdcall; external 'GCPlug.dll';

/// Registro do cancelamento do �ltimo cupom.
/// A ser executado quando o cancelamento do cupom � registrado (quando � efetivado).
/// O cancelamento refere-se ao �ltimo cupom registrado, que pode j� ter sido conclu�do ou n�o.
/// Caso o cancelamento tenha sido iniciado (ver GATECASH_CancelandoCupom()) e n�o efetivado,
/// basta n�o executar este comando.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_CancelandoCupom.
function GATECASH_CancelaCupom(): Integer; stdcall; external 'GCPlug.dll';

/// Adiciona detalhe a um cupom ou documento gen�rico.
/// Deve ser executado enquando houver um cupom ou documento gen�rico aberto.
/// A execu��o deste comando depende da regra de neg�cio da aplica��o.
/// Detalhes s�o listados ao visualizar um cupom ou documento gen�rico, mas n�o s�o computados
/// como vendas e n�o s�o totalizados no cupom ou documento gen�rico.
/// @param Nome String com nome do tipo de detalhe adicionado.
/// @param Complemento Descri��o complementar do detalhe adicionado.
/// Se n�o utilizado, informar string vazia ("").
/// @param Valor Valor associado ao detalhe. Se n�o aplic�vel, informar 0.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_InformaDetalhe(const Nome: string; const Complemento: string; Valor: Double): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de venda de item.
/// A ser executado quando a venda de item (com ou sem desconto) � registrada.
/// Se o item tiver acr�scimo ou desconto, esta diferen�a de valor deve ser informada chamando
/// GATECASH_DiferencaItem() logo ap�s o registro do item, informando o valor de acr�scimo/desconto.
/// @param Sequencia �ndice da seq��ncia do item vendido no cupom. � o mesmo �ndice que ser�
/// utilizado como refer�ncia para registro de diferen�a de item, cancelamento de item, etc.
/// @param Codigo String com c�digo do produto vendido (c�digo de barras).
/// @param Descricao String com descri��o do produto vendido.
/// @param Quantidade Quantidade da venda do produto.
/// @param ValorUnitario Valor unit�rio do produto.
/// Valor da venda � calculado por Quantidade X ValorUnit�rio.
/// @param Indice N�mero adicional associado � venda do item. A ser definido
/// pela regra de neg�cio. Se n�o dispon�vel, informar -1.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_DiferencaItem.
function GATECASH_VendeItem(Sequencia: Integer; const Codigo: string; const Descricao: string;
  Quantidade: Double; ValorUnitario: Double; Indice: Integer): Integer; stdcall; external 'GCPlug.dll';

/// In�cio do cancelamento de item.
/// A ser executado quando o processo de cancelamento de item � iniciado.
/// Em geral, quando o operador de caixa solicita a presen�a do supervisor para cancelar o item.
/// Este comando � opcional, pois em muitos sistemas de frente de caixa o "in�cio de cancelamento"
/// n�o passa pelo sistema.
/// Independente de executar GATECASH_CancelandoItem(), o comando GATECASH_CancelaItem()
/// dever� ser executado quando o cancelamento do item for efetivado (enviado � impressora).
/// @param Sequencia �ndice do item a ser cancelado.
/// Ex.: 1 indica o primeiro item do cupom. Se -1, indica �ltimo item vendido.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_CancelaItem.
function GATECASH_CancelandoItem(Sequencia: Integer): Integer; stdcall; external 'GCPlug.dll';

//* ****************************** UNDOCUMENTED METHODS ******************************** *//

/// Envia mensagem de evento com protocolo p�blico.
/// @param Mensagem String que retornar� com mensagem montada.
/// @param Tamanho Tamanho da string de retorno (em bytes).
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_EventoPublico(const Mensagem: string; Tamanho: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Monta mensagem de evento com protocolo p�blico.
/// A execu��o deste comando n�o depende da inicializa��o da comunica��o.
/// Este comando expoe os principais campos dispon�veis no protocolo p�blico,
/// mas apenas alguns campos s�o utilizados em cada tipo de evento.
/// Utilize valor ZERO ou strings NULAS como valores default dos campos.
/// @param Mensagem String que retornar� com mensagem montada.
/// @param Tamanho Tamanho da string de retorno (em bytes). Normalmente 140.
/// @param Pdv Identificador do PDV.
/// @param Evento C�digo indicando o tipo do evento.
/// @param Codigo C�digo do produto, forma de pagamento, funcion�rio, etc.
/// @param Descricao Descri��o/nome do produto, pagamento, funcion�rio, etc.
/// @param Unidade Unidade (2 caracteres) do produto vendido.
/// @param Quantidade Quantidade vendida.
/// @param ValorUnitario Valor unit�rio do produto vendido.
/// @param Valor Valor total do iten vendido.
/// @param Indice �ndice extra associado ao evento.
/// @param Obs Observa��es adicionais associadas ao evento.
/// @return 0: Sucesso ao montar mensagem.
/// @return -2: Par�metros inv�lidos. N�o foi poss�vel montar a mensagem.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_EventoPublico().
function GATECASH_MontaEventoPublico(Mensagem: string; Tamanho: Integer;
  Pdv: Integer; Evento: Integer;
  const Codigo: string; const Descricao: string;
  const Unidade: string; Quantidade: Float32;
  ValorUnitario: Float32; Valor: Float32;
  Indice: Integer; const Obs: string): Integer; stdcall; external 'GCPlug.dll';

/// Registro de recebimento de item.
/// A ser executado quando uma troca ou devolu��o de produto � realizada.Utilizada tamb�m em recebimento de mercadorias;
///  ---------------  Atributos abaixo devem ser analisados: ----------------------------
/// Se o item tiver acr�scimo ou desconto, esta diferen�a de valor deve ser informada chamando
/// GATECASH_DiferencaItem() logo ap�s o registro do item, informando o valor de acr�scimo/desconto.
/// @param Sequencia �ndice da seq��ncia do item vendido no cupom. � o mesmo �ndice que ser�
/// utilizado como refer�ncia para registro de diferen�a de item, cancelamento de item, etc.
/// @param Codigo String com c�digo do produto vendido (c�digo de barras).
/// @param Descricao String com descri��o do produto vendido.
/// @param Quantidade Quantidade da venda do produto.
/// @param ValorUnitario Valor unit�rio do produto.
/// Valor da venda � calculado por Quantidade X ValorUnit�rio.
/// @param Indice N�mero adicional associado � venda do item. A ser definido
/// pela regra de neg�cio. Se n�o dispon�vel, informar -1.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunica��o n�o inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_DiferencaItem.
function GATECASH_RecebeItem(Sequencia: Integer; const Codigo: string; const Descricao: string;
  Qunantidade: Double; ValorUnitario: Double; Indice: Integer): Integer; stdcall; external 'GCPlug.dll';

implementation

{ TResponseHelper }

function IntToResponse(Value: Integer): TResponse;
begin
  case Value of
    0:
      Result := TResponse.SUCCESS;
    -1:
      Result := TResponse.COMMANDNOTINITIALIZED;
    -2:
      Result := TResponse.INVALIDPARAMS
    else
      Result := TResponse.COMMANDFAILURE;
  end;
end;

function TResponseHelper.ToInteger: Integer;
begin
  case Self of
    TResponse.SUCCESS:
      Result := 0;
    TResponse.COMMANDNOTINITIALIZED:
      Result := -1;
    TResponse.INVALIDPARAMS:
      Result := -2
    else
      Result := -999;
  end;
end;

function TResponseHelper.ToString: string;
begin
  case Self of
    TResponse.SUCCESS:
      Result := '0';
    TResponse.COMMANDNOTINITIALIZED:
      Result := '-1';
    TResponse.INVALIDPARAMS:
      Result := '-2'
    else
      Result := '-999';
  end;
end;

function TResponseHelper.ToText: string;
begin
  case Self of
    TResponse.SUCCESS:
      Result := 'Comunica��o realizada com sucesso.';
    TResponse.COMMANDNOTINITIALIZED:
      Result := 'Comunica��o n�o inicializada';
    TResponse.INVALIDPARAMS:
      Result := 'Par�metros inv�lidos. N�o foi poss�vel montar a mensagem.';
    else
       Result := 'Falha ao executar comando.';
  end;
end;

end.
