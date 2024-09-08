import SwiftUI
import Kingfisher

struct ProductDetailView: View {
    let product: ProductsListResultModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            productImageCarousel
            productDetails
            Spacer()
        }
        .padding(16)
        .background(Color(UIColor.systemBackground))
    }
    
    private var productImageCarousel: some View {
        TabView {
            ForEach(product.imageURLs, id: \.self) { url in
                KFImage(URL(string: url))
                    .placeholder {
                           ProgressView()
                               .frame(height: 300)
                       }
                       .resizable()
                       .aspectRatio(contentMode: .fill)
                       .frame(height: 300)
                       .clipped()
               }
           }
           .tabViewStyle(PageTabViewStyle())
           .frame(height: 300)
           .background(Color(UIColor.secondarySystemBackground))
           .cornerRadius(10)
           .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
       }

       private var productDetails: some View {
           VStack(alignment: .leading, spacing: 8) {
               Text(product.name)
                   .font(.largeTitle)
                   .bold()
               
               Text("$\(product.price)")
                   .font(.title2)
                   .foregroundColor(.green)
               
               Text("Created At: \(product.createdAt)")
                   .font(.subheadline)
                   .foregroundColor(.secondary)
           }
       }
}

#Preview {
    ProductDetailView(product: ProductsListResultModel(createdAt: "2019-02-24 04:04:17.566515", price: "AED 5", name: "Notebook", uid: "4878bf592579410fba52941d00b62f94", imageIDs: ["9355183956e3445e89735d877b798689"], imageURLs: ["https://demo-app-photos-45687895456123.s3.amazonaws.com/9355183956e3445e89735d877b798689?AWSAccessKeyId=ASIASV3YI6A4XLFJCD3S&Signature=l%2BaYiWE2660uEY4wIztE3xQNzbs%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEBcaCXVzLWVhc3QtMSJHMEUCIHo9XP%2FNBdx1amsae7TM3aM6FSPnIQoESL4UhECnJWTDAiEA3db0%2FcA2UJanY6OhN9xUp7S%2F%2Fim4%2F7Dur%2BawaBflgtQq8gIIQBAFGgwxODQzOTg5NjY4NDEiDItLWWlPxl2yEnfj2irPAm5BeOnrxEWDmf7yJp5o6rIYkzMr3RSaCQl5J8PXdGd1LTQALDYOSGXLubhNgNpNUH39Orldg0y7kWHNXFv1O5DuyPQIfqGJKL0jl1Bk%2FBTSIjlPLJ0X03%2BZFpDPngf1WrGlfHfUnwWkiQmmvO7jMFwrB4NGXJ6%2FpB3ArgMasfIAIBa0rb1jrigVpOrBt1COjxkGBPnsq4hNsHw5QPocgFr9Y%2BxyBZ927VMo%2B2IlpUi7ZD5nEn2F4h5MeNqcZdgYN6ijtgY3gMmmKcMmnanAOsUk%2FLfbUlOm2DUCvL5N5F0s6F4sxONUP1bH8Iq7Ghyg5WQEQYHPeNV5IUHQzanfiwkKrBMh308FWUarLXUQstVlnx%2FcexmE4XE22zdg%2F0m1JrZJ%2FxVXggEkPOT0IZKqnzCGG%2F23ikY1LTVHs3ABnNoCGMGFyW6dYw2VnGsFZ8wIMMOO9bYGOp4BYHYuIeeOjkKjK1FwsUt%2FS7dY3Nu6TCh7ULmDKa3WBtcmm5c3k5fXbPjjA1hsoPhtR168JhyMJ4%2FYlDeM1z9IDbzpZJhomuTIlqHpakahHtzq0b2F065TkUEppnvEKMWvuqKv%2FWow0m%2BTsTX%2FB%2FQ2fCwpggdcMbzqR%2BAwO13lah8XbTn3DLsJbrZykRXSr1jnCrrUOABRJBS%2BO0leoMM%3D&Expires=1725781848"], imageURLsThumbnails: ["ret"]))
}
