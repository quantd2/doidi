namespace :db do
  desc "Fill database with sample data"

  task populate_user: :environment do
    User.create!( email: "quan1@gmail.com",
                  name: "quan1",
                  phone: "555555551",
                  password: "foobar",
                  password_confirmation: "foobar",
                  admin: true)

    User.create!( email: "quan2@gmail.com",
                  name: "quan2",
                  phone: "555555552",
                  password: "foobar",
                  password_confirmation: "foobar")
  end

  task populate_location: :environment do
    hcm_id = Location.create!( name: "Tp Hồ Chí Minh" ).id
    Location.create!( name: "Quận 1", parent_id: hcm_id )
    Location.create!( name: "Quận 2", parent_id: hcm_id )
    Location.create!( name: "Quận 3", parent_id: hcm_id )
    Location.create!( name: "Quận 9", parent_id: hcm_id )
    Location.create!( name: "Quận 4", parent_id: hcm_id )
    Location.create!( name: "Quận 5", parent_id: hcm_id )
    Location.create!( name: "Quận 6", parent_id: hcm_id )
    Location.create!( name: "Quận 7", parent_id: hcm_id )
    Location.create!( name: "Quận 8", parent_id: hcm_id )
    Location.create!( name: "Quận 10", parent_id: hcm_id )
    Location.create!( name: "Quận 11", parent_id: hcm_id )
    Location.create!( name: "Quận 12", parent_id: hcm_id )
    Location.create!( name: "Quận Thủ Đức", parent_id: hcm_id )
    Location.create!( name: "Quận Gò Vấp", parent_id: hcm_id )
    Location.create!( name: "Quận Bình Thạnh", parent_id: hcm_id )
    Location.create!( name: "Quận Tân Bình", parent_id: hcm_id )
    Location.create!( name: "Quận Tân Phú", parent_id: hcm_id )
    Location.create!( name: "Quận Phú Nhuận", parent_id: hcm_id )
    Location.create!( name: "Quận Bình Tân", parent_id: hcm_id )
    Location.create!( name: "Huyện Củ Chi", parent_id: hcm_id )
    Location.create!( name: "Huyện Hóc Môn", parent_id: hcm_id )
    Location.create!( name: "Huyện Bình Chánh", parent_id: hcm_id )
    Location.create!( name: "Huyện Nhà Bè", parent_id: hcm_id )
    Location.create!( name: "Huyện Cần Giờ", parent_id: hcm_id )

    hn_id = Location.create!( name: "Hà Nội" ).id
    Location.create!( name: "Quận Ba Đình", parent_id: hn_id )
    Location.create!( name: "Quận Hoàn Kiếm", parent_id: hn_id )
    Location.create!( name: "Quận Hai Bà Trưng", parent_id: hn_id )
    Location.create!( name: "Quận Đống Đa", parent_id: hn_id )
    Location.create!( name: "Quận Tây Hồ", parent_id: hn_id )
    Location.create!( name: "Quận Cầu Giấy", parent_id: hn_id )
    Location.create!( name: "Quận Thanh Xuân", parent_id: hn_id )
    Location.create!( name: "Quận Hoàng Mai", parent_id: hn_id )
    Location.create!( name: "Quận Long Biên", parent_id: hn_id )
    Location.create!( name: "Huyện Từ Liêm", parent_id: hn_id )
    Location.create!( name: "Huyện Thanh Trì", parent_id: hn_id )
    Location.create!( name: "Huyện Gia Lâm", parent_id: hn_id )
    Location.create!( name: "Huyện Đông Anh", parent_id: hn_id )
    Location.create!( name: "Huyện Sóc Sơn", parent_id: hn_id )
    Location.create!( name: "Quận Hà Đông", parent_id: hn_id )
    Location.create!( name: "Thị xã Sơn Tây", parent_id: hn_id )
    Location.create!( name: "Huyện Ba Vì", parent_id: hn_id )
    Location.create!( name: "Huyện Phúc Thọ", parent_id: hn_id )
    Location.create!( name: "Huyện Thạch Thất", parent_id: hn_id )
    Location.create!( name: "Huyện Quốc Oai", parent_id: hn_id )
    Location.create!( name: "Huyện Chương Mỹ", parent_id: hn_id )
    Location.create!( name: "Huyện Đan Phượng", parent_id: hn_id )
    Location.create!( name: "Huyện Hoài Đức", parent_id: hn_id )
    Location.create!( name: "Huyện Thanh Oai", parent_id: hn_id )
    Location.create!( name: "Huyện Mỹ Đức", parent_id: hn_id )
    Location.create!( name: "Huyện Ứng Hoà", parent_id: hn_id )
    Location.create!( name: "Huyện Thường Tín", parent_id: hn_id )
    Location.create!( name: "Huyện Phú Xuyên", parent_id: hn_id )
    Location.create!( name: "Huyện Mê Linh", parent_id: hn_id )
  end

  task populate_category: :environment do
    Category.create!(name: "Sách")
    Category.create!(name: "Đồ em bé")
  end

end
