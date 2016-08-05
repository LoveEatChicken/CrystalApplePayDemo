//
//  ViewController.m
//  CrystalApplePayDemo
//
//  Created by Crystal on 16/8/5.
//  Copyright © 2016年 crystal. All rights reserved.
//

#import "ViewController.h"
#import <PassKit/PassKit.h>

static NSString *const MerchantIdentifer = @"merchant.cn.joymason.applepay";

@interface ViewController ()<PKPaymentAuthorizationViewControllerDelegate>

@end

@implementation ViewController

#pragma mark lifecycle method

- (void)viewDidLoad {
    [super viewDidLoad];

    PKPaymentButton *paybutton = [[PKPaymentButton alloc] initWithPaymentButtonType:PKPaymentButtonTypeBuy paymentButtonStyle:PKPaymentButtonStyleWhiteOutline];
    
    [paybutton setFrame:CGRectMake(0, 0, 80, 30)];
    [paybutton setCenter:self.view.center];
    [paybutton addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:paybutton];
    
}

#pragma mark action method

- (void)pay:(PKPaymentButton *)payButton {
    
    PKPaymentRequest *payRequest = [[PKPaymentRequest alloc] init];
    
    payRequest.merchantIdentifier = MerchantIdentifer;
    payRequest.countryCode = @"CN";
    payRequest.supportedNetworks = @[PKPaymentNetworkChinaUnionPay];
    payRequest.merchantCapabilities = PKMerchantCapability3DS | PKMerchantCapabilityEMV | PKMerchantCapabilityCredit | PKMerchantCapabilityDebit;
    payRequest.currencyCode = @"CNY";
    PKPaymentSummaryItem *totalItem = [PKPaymentSummaryItem summaryItemWithLabel:@"尹成真" amount:[NSDecimalNumber decimalNumberWithString:@"0.1"]type:PKPaymentSummaryItemTypeFinal];
    payRequest.paymentSummaryItems = @[totalItem];
    
    PKPaymentAuthorizationViewController *vc = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:payRequest];
    
    vc.delegate = self;
    
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark PKPaymentAuthorizationViewControllerDelegate method

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus status))completion {
    
    //许可回调
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
