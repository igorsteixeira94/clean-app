import Domain

extension AccountModel {
    static func stub() -> AccountModel {
        AccountModel(id: "any_id",
                     name: "Jon Doe",
                     email: "jonDoe@mail.com",
                     password: "123456")
    }
}
