#import <Foundation/Foundation.h>
#import "WMTOACategoryTaxonomy.h"
#import "WMTOAApi.h"

/**
 * NOTE: This class is auto generated by the swagger code generator program. 
 * https://github.com/swagger-api/swagger-codegen 
 * Do not edit the class manually.
 */


@interface WMTOATaxonomyApi: NSObject <WMTOAApi>

extern NSString* kWMTOATaxonomyApiErrorDomain;
extern NSInteger kWMTOATaxonomyApiMissingParamErrorCode;

+(instancetype) sharedAPI;

/// Get the category taxonomy used by walmart.com to categorize items.
/// Category taxonomy describes three levels - Departments, Categories and Sub-categories as available on Walmart.com. It is possible to specify the exact category as a parameter when using any of the API's below:  Search Data feeds  Special feeds - [Pre-order, Best sellers, Rollbacks, Clearance and Special buys] For example, Search API can be restricted to search within a category by supplying id as per the taxonomy. Similarly, Feed API can be used to download category specific feeds by specifying a category id.
///
/// @param apiKey Your API access key.
/// @param format Type of response required, allowed values [json, xml]. (optional) (default to json)
/// 
///  code:200 message:"successful operation",
///  code:500 message:"Internal Server error"
///
/// @return WMTOACategoryTaxonomy*
-(NSNumber*) getCategoryTaxonomyWithApiKey: (NSString*) apiKey
    format: (NSString*) format
    completionHandler: (void (^)(WMTOACategoryTaxonomy* output, NSError* error)) handler;



@end
