/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utils;

/**
 *
 * @author Felipe
 */
public class teste {
    public static void main(String[] args) {
        String a = "O campo \"Nome\" nao pode conter numeros.\nO campo \"Email\" esta preenchido de forma incorreta.||";
        String[] b = a.split("\n");
        
        System.out.println(b[0]);
    }
}
