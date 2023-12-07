import React, { Fragment } from 'react'
import { Menu, Popover, Transition } from '@headlessui/react'
import { HiOutlineBell, HiOutlineSearch, HiOutlineChatAlt } from 'react-icons/hi'
import { useNavigate } from 'react-router-dom'
import classNames from 'classnames'
import { Link } from 'react-router-dom'
import imageBK from '../../assets/images/BK.png'

export default function Header() {
	const navigate = useNavigate()
	const logout = async () => {
		const expirationTime = new Date(Date.now() - 60 * 1000);
		document.cookie = `admin_cookie_id=null; expires=${expirationTime.toUTCString()}; path=/`;
		window.location.href = 'http://localhost:3000/login';
    };
	return (
		<div className="bg-mainBlue h-16 px-4 flex items-center border-b border-gray-200 justify-between">
			<div className="flex items-center py-3">
				<Link to='/admin'>
					<img src={imageBK} alt='imageBK' width={50} height={50}></img>
				</Link>
				<Link to='/admin'>
					<p className="text-white text-sm ">HỆ THỐNG QUẢN LÝ DỮ LIỆU</p>
					<p className="text-white text-sm ">CHUỖI CỬA HÀNG CÀ PHÊ - PLACY</p>
				</Link>
			</div>
			<div className="flex items-center gap-2 mr-2">
				<Menu as="div" className="relative">
					<Transition
						as={Fragment}
						enter="transition ease-out duration-100"
						enterFrom="transform opacity-0 scale-95"
						enterTo="transform opacity-100 scale-100"
						leave="transition ease-in duration-75"
						leaveFrom="transform opacity-100 scale-100"
						leaveTo="transform opacity-0 scale-95"
					>
						<Menu.Items className="origin-top-right z-10 absolute right-0 mt-2 w-48 rounded-sm shadow-md p-1 bg-white ring-1 ring-black ring-opacity-5 focus:outline-none">
							<Menu.Item>
								{({ active }) => (
									<div
										onClick={() => navigate('/admin/infoAdmin')}
										className={classNames(
											active && 'bg-gray-100',
											'active:bg-gray-200 rounded-sm px-4 py-2 text-gray-700 cursor-pointer focus:bg-gray-200'
										)}
									>
										Thông Tin
									</div>
								)}
							</Menu.Item>
							<Menu.Item>
								{({ active }) => (
									<button onClick={logout}
										className={classNames(
											active && 'bg-gray-100',
											'active:bg-gray-200 rounded-sm px-4 py-2 text-gray-700 cursor-pointer focus:bg-gray-200'
										)}
									>
										Đăng xuất
									</button>
								)}
							</Menu.Item>
						</Menu.Items>
					</Transition>
				</Menu>
			</div>
		</div>
	)
}
