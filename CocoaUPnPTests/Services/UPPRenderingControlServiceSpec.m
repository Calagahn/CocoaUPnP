// CocoaUPnP by A&R Cambridge Ltd, http://www.arcam.co.uk
// Copyright 2015 Arcam. See LICENSE file.

#import "UPPRenderingControlService.h"
#import "UPPConstants.h"
#import "UPPSessionManager.h"
#import "NetworkTestHelpers.h"

SpecBegin(UPPRenderingControlService)

describe(@"UPPRenderingControlService", ^{
    
    __block UPPRenderingControlService *service;
    __block id sessionManager;
    __block NSString *url;
    __block NSString *instanceId;
    __block NSError *error;
    
    beforeEach(^{
        service = [[UPPRenderingControlService alloc] init];
        service.nameSpace = @"urn:schemas-upnp-org:service:RenderingControl:1";
        
        sessionManager = [OCMockObject mockForClass:[UPPSessionManager class]];
        service.sessionManager = sessionManager;
        
        url = @"http://127.0.0.1/ctrl";
        NSURL *controlURL = [NSURL URLWithString:url];
        service.controlURL = controlURL;
        
        instanceId = @"0";
        error = nil;
    });
    
    describe(@"mute status", ^{
        
        __block NSDictionary *params;
        __block NSDictionary *expectedParams;
        __block NSString *channel;
        
        beforeEach(^{
            channel = @"Master";
        });
        
        describe(@"when getting mute", ^{
            
            beforeEach(^{
                params = @{ @"InstanceID": instanceId,
                            @"Channel": channel };
                expectedParams = @{ UPPSOAPActionKey: @"GetMute",
                                    UPPNameSpaceKey: service.nameSpace,
                                    UPPParametersKey: params };
            });
            
            it(@"should send required parameters", ^{
                VerifyGetPostWithParams(expectedParams, sessionManager, url);
                
                [service muteWithInstanceID:instanceId channel:channel completion:^(NSDictionary *response, NSError *error) {
                    expect(response).toNot.beNil();
                    expect(error).to.beNil();
                }];
                
                [sessionManager verify];
            });
            
            it(@"should send required parameters with convenience call", ^{
                VerifyGetPostWithParams(expectedParams, sessionManager, url);
                
                [service muteWithInstanceID:instanceId completion:^(NSDictionary *response, NSError *error) {
                    expect(response).toNot.beNil();
                    expect(error).to.beNil();
                }];
                
                [sessionManager verify];
            });
        });
        
        describe(@"when setting mute", ^{
            beforeEach(^{
                params = @{ @"InstanceID": instanceId,
                            @"Channel": channel,
                            @"DesiredMute": @1 };
                
                expectedParams = @{ UPPSOAPActionKey: @"SetMute",
                                    UPPNameSpaceKey: service.nameSpace,
                                    UPPParametersKey: params };
            });
            
            it(@"should send required parameters", ^{
                VerifyPostWithParams(expectedParams, sessionManager, url);
                
                [service setMuteWithInstanceID:instanceId
                                       channel:channel
                                          mute:YES
                                         error:&error];
                
                [sessionManager verify];
                expect(error).to.beNil();
            });
            
            it(@"should send required parameters with convenience call", ^{
                VerifyPostWithParams(expectedParams, sessionManager, url);
                
                [service setMuteWithInstanceID:instanceId
                                          mute:YES
                                         error:&error];
                
                [sessionManager verify];
                expect(error).to.beNil();
            });
            
            it(@"should send required parameters with mute off", ^{
                params = @{ @"InstanceID": instanceId,
                            @"Channel": channel,
                            @"DesiredMute": @0 };
                
                expectedParams = @{ UPPSOAPActionKey: @"SetMute",
                                    UPPNameSpaceKey: service.nameSpace,
                                    UPPParametersKey: params };
                VerifyPostWithParams(expectedParams, sessionManager, url);
                
                [service setMuteWithInstanceID:instanceId
                                          mute:NO
                                         error:&error];
                
                [sessionManager verify];
                expect(error).to.beNil();
            });
        });
    });
});

SpecEnd