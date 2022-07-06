
import Foundation
struct SmartCollections : Codable {

	let id : Int?
	let handle : String?
	let title : String?
	let updated_at : String?
	let body_html : String?
	let published_at : String?
	let sort_order : String?
	let template_suffix : String?
	let disjunctive : Bool?
	let rules : [Rules]?
	let published_scope : String?
	let admin_graphql_api_id : String?
	let image : ImageData?

}
