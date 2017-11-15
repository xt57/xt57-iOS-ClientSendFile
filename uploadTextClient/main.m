//
//  main.m
//  uploadTextClient
//
//  Created by ag20253 on 10/19/17.
//  Copyright © 2017 ag20253. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
	@autoreleasepool {

		NSString* str = @"2017-10-17 14:25.033 | iPad = 003452 | Level=3 | AcctKey = 369563321\n2017-10-17 14:25.047 | iPad = 003452 | Level=3 | Verified Rick\'s ID";
		
		NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
		
		NSString *urlString =[NSString stringWithFormat:@"http://localhost:8181"];
		
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
		[request setURL:[NSURL URLWithString:urlString]];
		[request setHTTPMethod:@"POST"];
		

		NSString *boundary = @"_187934598797439873422234";
		NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
		[request setValue:contentType forHTTPHeaderField: @"Content-Type"];
		[request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
		[request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/536.26.14 (KHTML, like Gecko) Version/6.0.1 Safari/536.26.14" forHTTPHeaderField:@"User-Agent"];
		[request setValue:@"http://google.com" forHTTPHeaderField:@"Origin"];
		

		NSMutableData *body = [NSMutableData data];
		[body appendData:[[NSString stringWithFormat:@"Content-Length %lu\r\n\r\n", (unsigned long)[data length] ] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"picture\"; filename=\"%@.txt\"\r\n", @"newfile"] dataUsingEncoding:NSUTF8StringEncoding]];
		

		[body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		
		[body appendData:[NSData dataWithData:data]];
		
		[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
		
		

		[request setHTTPBody:body];
		[request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)[body length]] forHTTPHeaderField:@"Content-Length"];
		

		NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
		NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
		NSLog(@"%@", returnString);
		
	}

	return 0;
}



