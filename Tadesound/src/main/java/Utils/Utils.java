package Utils;

public class Utils {
    public static String validaDadosInseridosCliente(String nome, String email, String cpf, String dataNascimento, String telefone, String endereco, int numero, String complemento, String bairro, String cidade, String uf, String cep) {
        String msgErro = "";

        //Validacao para o campo nome
        if (nome.matches(".*\\d.*")) {
            msgErro += "O campo \"Nome\" nao pode conter numeros.   ";
        } else if (nome.length() < 3) {
            msgErro += "O campo \"Nome\" deve possuir ao menos 3 caracteres.   ";
        } else if (nome.length() > 255) {
            msgErro += "O campo \"Nome\" deve possuir no maximo 255 caracteres.   ";
        }
        
        //Validacao para o campo email
        if (!email.contains("@")) {
            msgErro += "O campo \"Email\" esta preenchido de forma incorreta.   ";
        }
        
        //Validacao para o campo CPF
        if (cpf.length() < 11) {
            msgErro += "O campo \"CPF\" deve conter ao menos 11 digitos.   ";
        } else if (cpf.length() > 11) {
            msgErro += "O campo \"CPF\" deve conter no maximo 11 digitos.   ";
        }
        
        //Caso todos os dados estejam corretos
        if (msgErro.equals("")) {
            return null;
        }
        
        //Caso tenha algo de errado, retornar a String com os errros.
        return msgErro;
    }
}
