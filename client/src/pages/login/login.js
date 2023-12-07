import React, { useState } from 'react';
import LoginComponent from '../../components/Login';
import backgroundImage from '../../assets/images/homeBK.jpg'
import logoImage from '../../assets/images/BK.jpg';

export default function Login() {
	return (
		<div className="w-full h-screen flex justify-center items-center bg-cover " style={{ backgroundImage: `url(${backgroundImage})` }}>
			<div className="w-96 h-222 bg-white rounded-2xl flex items-center flex-col">
				<div className="w-20 flex justify-center">
					<a><img src={logoImage} alt="Logo BK" className="mt-8 mb-4 w-full object-cover object-center rounded-md" /></a>
				</div>
				<h1 className="text-gray-700 text-2xl font-bold">Đăng nhập</h1>
				<LoginComponent />
			</div>
		</div>
	);
}