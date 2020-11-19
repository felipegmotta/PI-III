package Model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Fornecedor {
    
    //Construtor sem data de cadastro
    public Fornecedor(String nome, String CPFOuCNPJ, String telefone, String email, String endereco, int numero, String complemento, String bairro, String cidade, String uf, String cep) {
        this.nome = nome;
        this.telefone = telefone;
        this.email = email;
        this.endereco = endereco;
        this.numero = numero;
        this.complemento = complemento;
        this.bairro = bairro;
        this.cidade = cidade;
        this.uf = uf;
        this.cep = cep;
        
        if (CPFOuCNPJ.length() > 11) {
            this.cnpj = CPFOuCNPJ;
            this.cpf = "";
        } else {
            this.cpf = CPFOuCNPJ;
            this.cnpj = "";
        }
    }
    
    //Construtor com data de cadastro e id do Fornecedor
    public Fornecedor(int idFornecedor, String nome, String CPFOuCNPJ, String telefone, String email, String endereco, int numero, String complemento, String bairro, String cidade, String uf, String cep, String dataCadastro) {
        this.idFornecedor = idFornecedor;
        this.nome = nome;
        this.telefone = telefone;
        this.email = email;
        this.endereco = endereco;
        this.numero = numero;
        this.complemento = complemento;
        this.bairro = bairro;
        this.cidade = cidade;
        this.uf = uf;
        this.cep = cep;
        this.dataCadastro = dataCadastro;
        
        if (CPFOuCNPJ.length() > 11) {
            this.cnpj = CPFOuCNPJ;
            this.cpf = "";
        } else {
            this.cpf = CPFOuCNPJ;
            this.cnpj = "";
        }
    }
    
    //Construtor sem data de cadastro e com id do Fornecedor
    public Fornecedor(int idFornecedor, String nome, String CPFOuCNPJ, String telefone, String email, String endereco, int numero, String complemento, String bairro, String cidade, String uf, String cep) {
        this.idFornecedor = idFornecedor;
        this.nome = nome;
        this.telefone = telefone;
        this.email = email;
        this.endereco = endereco;
        this.numero = numero;
        this.complemento = complemento;
        this.bairro = bairro;
        this.cidade = cidade;
        this.uf = uf;
        this.cep = cep;
        
        if (CPFOuCNPJ.length() > 11) {
            this.cnpj = CPFOuCNPJ;
            this.cpf = "";
        } else {
            this.cpf = CPFOuCNPJ;
            this.cnpj = "";
        }
    }

    private int idFornecedor;
    private String nome;
    private String cpf;
    private String cnpj;
    private String telefone;
    private String email;
    private String endereco;
    private int numero;
    private String complemento;
    private String bairro;
    private String cidade;
    private String uf;
    private String cep;
    private String dataCadastro;
}
