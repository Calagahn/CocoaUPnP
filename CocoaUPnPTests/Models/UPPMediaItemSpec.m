#import "UPPMediaItem.h"

SpecBegin(UPPMediaItem)

describe(@"UPPMediaItem", ^{
    
    __block UPPMediaItem *mediaItem;
    __block NSString *url;
    
    beforeEach(^{
        mediaItem = [[UPPMediaItem alloc] init];
        url = @"http://localhost/example.png";
    });
    
    it(@"should conform to UPPMediaItemProtocol", ^{
        expect(mediaItem).to.conformTo(@protocol(UPPMediaItemProtocol));
    });
    
    it(@"should allow setting an album title", ^{
        NSString *string = @"Title";
        mediaItem.albumTitle = string;
        expect(mediaItem.albumTitle).to.equal(string);
    });
    
    it(@"should allow setting an artist", ^{
        NSString *string = @"Artist";
        mediaItem.artist = string;
        expect(mediaItem.artist).to.equal(string);
    });
    
    it(@"should allow setting date", ^{
        NSString *string = @"1994";
        mediaItem.date = string;
        expect(mediaItem.date).to.equal(string);
    });
    
    it(@"should allow setting genre", ^{
        NSString *string = @"Rock";
        mediaItem.genre = string;
        expect(mediaItem.genre).to.equal(string);
    });
    
    it(@"should state if it is a container", ^{
        mediaItem.isContainer = YES;
        expect(mediaItem.isContainer).to.equal(YES);
    });
    
    it(@"should allow object class", ^{
        NSString *string = @"class";
        mediaItem.objectClass = string;
        expect(mediaItem.objectClass).to.equal(string);
    });
    
    it(@"should allow setting object identifier", ^{
        NSString *string = @"asdf";
        mediaItem.objectID = string;
        expect(mediaItem.objectID).to.equal(string);
    });
    
    it(@"should allow setting track number", ^{
        NSString *string = @"10";
        mediaItem.trackNumber = string;
        expect(mediaItem.trackNumber).to.equal(string);
    });
    
    it(@"should allow setting parent identifier", ^{
        NSString *string = @"sdfg";
        mediaItem.parentID = string;
        expect(mediaItem.parentID).to.equal(string);
    });
    
    it(@"should allow setting a number of resources", ^{
        NSString *string = @"resource";
        NSArray *resources = @[ string, string ];
        mediaItem.resources = resources;
        expect(mediaItem.resources).to.equal(resources);
    });
    
    it(@"should allow setting item title", ^{
        NSString *string = @"title";
        mediaItem.itemTitle = string;
        expect(mediaItem.itemTitle).to.equal(string);
    });

    it(@"should return an album art URL", ^{
        mediaItem.albumArtURLString = url;
        expect(mediaItem.albumArtURL.absoluteString).to.equal(url);
    });
    
});

SpecEnd