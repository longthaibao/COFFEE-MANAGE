import React from 'react';
import AdminInfo from '../../components/AdminInfo';

export default function testlaythongtincanhan() {
	const handleAuthorization = (role) => {
		const cookies = document.cookie.split('; ');
		for (const cookie of cookies) {
		  const [name, value] = cookie.split('=');
		  if(name === role) {
			return true
		  }
		}
		window.location.href = 'http://localhost:3000/login';
	}
	if(handleAuthorization('admin_cookie_id'))
	return (
		<AdminInfo/>
	);
}