
import Foundation
struct ProductsResult : Codable {
	let id : Int?
	let title : String?
	let body_html : String?
	let vendor : String?
	let product_type : String?
	let created_at : String?
	let handle : String?
	let updated_at : String?
	let published_at : String?
	let template_suffix : String?
	let status : String?
	let published_scope : String?
	let tags : String?
	let admin_graphql_api_id : String?
	let variants : [Variants]?
	let options : [Options]?
	let images : [ImagesResult]?
	let image : ImageResult?

}
