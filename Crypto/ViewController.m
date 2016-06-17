//
//  ViewController.m
//  Crypto
//
//  Created by Wilson Wistuba on 6/17/16.
//  Copyright © 2016 Wilson Wistuba. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+AES256.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Essa é a chave que estamos utilizando agora
    NSString *key32 = @"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
    
    NSString *textEncript = @"1234ABCDEF";
    NSLog(@"1. Dado para Encriptar: %@",textEncript);
    
    NSData *data = [textEncript dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"2. Dado para Encriptar - NSData: %@",data);
    
    //Criptografia
    
    //Faz a criptografia simples sem transformar em String, apenas de exemplo
    NSData *encryptedDatatst = [data AES256EncryptWithKey:key32];
    NSLog(@"3. Dado Criptografado - NSData: %@",encryptedDatatst);
    
    //Essa é a linha para gravar no DB (Firebase), criptografa e transforma em String Base 64
    NSString *encryptedData = [[data AES256EncryptWithKey:key32] base64EncodedStringWithOptions:0];
    NSLog(@"4. Dado Criptografado - NSString - Base 64: %@",encryptedData);
    

    //Decriptografia

    //A string encryptedData é o campo senha ou cpf que se recupera do banco!!!
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:encryptedData options:0];
    NSLog(@"5. Dado para decriptografar - NSData: %@",decodeData);
    
    //Faz a decriptografia simples sem transformar em String
    NSData *dataDecryptTst = [decodeData AES256DecryptWithKey:key32];
    NSLog(@"6. Dado Decriptografado - NSData: %@",dataDecryptTst);

    //Transforma o dado decriptogrado em String, esse é o código para usar no App
    NSString *decodedString = [[NSString alloc] initWithData:dataDecryptTst encoding:NSUTF8StringEncoding];
    NSLog(@"7. Dado Decripografado - NSString - UFT8: %@",decodedString);
    
    
    
    
    

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *) stringFromHex:(NSString *)str
{
    NSMutableData *stringData = [[NSMutableData alloc] init] ;
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [str length] / 2; i++) {
        byte_chars[0] = [str characterAtIndex:i*2];
        byte_chars[1] = [str characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [stringData appendBytes:&whole_byte length:1];
    }
    
    return [[NSString alloc] initWithData:stringData encoding:NSASCIIStringEncoding];
}

- (NSString *) stringToHex:(NSString *)str
{
    NSUInteger len = [str length];
    unichar *chars = malloc(len * sizeof(unichar));
    [str getCharacters:chars];
    
    NSMutableString *hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i = 0; i < len; i++ )
    {
        [hexString appendString:[NSString stringWithFormat:@"%x", chars[i]]];
    }
    free(chars);
    
    return hexString;
}









@end
