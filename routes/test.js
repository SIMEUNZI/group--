// import {atom} from 'recoil';
// import {recoilPersist} from 'recoil-persist';

// const {persistAtom} = recoilPersist({
//   key: 'user',
//   storage: localStorage,
// });

// export const userState = atom({
//   key: 'users/userState',
//   default: {
//     id: '',
//     name: '',
//     email: '',
//     cellphone: '',
//     zip: '',
//     address: '',
//     addressDetail: '',
//     createdAt: '',
//     updatedAt: '',
//   },
//   effects: [persistAtom],
// });


getWishlist: `SELECT p.name, p.sale_price
                FROM user u
                JOIN wishlist w ON u.user_id = w.user_id
                JOIN product p ON w.product_id = p.product_id
                WHERE u.user_id = ?`,