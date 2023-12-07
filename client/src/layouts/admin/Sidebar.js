import React from 'react'
import classNames from 'classnames'
import { Link, useLocation } from 'react-router-dom'
import {
	HiOutlineViewGrid,
	HiOutlineLogout,
	HiOutlineChartPie,
	HiOutlineChartBar
} from 'react-icons/hi'

const DASHBOARD_SIDEBAR_LINKS = [
	{
		key: 'info',
		label: 'test lấy thông tin cá nhân',
		path: '/admin/test_laythongtincanhantubangemployee',
		icon: <></>
	},
	{
		key: 'themxoasua',
		label: 'themxoasua',
		path: '/admin/themxoasua',
		icon: <HiOutlineViewGrid/>
	},
	{
		key: 'thutuc1',
		label: 'thutuc1: show bang nhan vien theo chi nhanh',
		path: '/admin/thutuc1',
		icon: <HiOutlineChartBar />
	},
	{
		key: 'thutuc2',
		label: 'thutuc2: thong ke doanh thu theo CTKM',
		path: '/admin/thutuc2',
		icon: <HiOutlineChartPie />
	}
]

function SidebarLink({ link }) {
	const { pathname } = useLocation()

	return (
		<Link
			to={link.path}
			className={classNames(pathname === link.path ? 'bg-lightGray text-mainBlue' : 'text-textGray', linkClass)}
		>
			<span className="text-xl">{link.icon}</span>
			{link.label}
		</Link>
	)
}

const linkClass =
	'flex items-center gap-2 px-3 py-2 hover:bg-lightGray hover:no-underline rounded-[12px] text-base font-semibold'

export default function Sidebar() {
	const logout = async () => {
		const expirationTime = new Date(Date.now() - 60 * 1000);
		document.cookie = `admin_cookie_id=null; expires=${expirationTime.toUTCString()}; path=/`;
		window.location.href = 'http://localhost:3000/login';
    };
	return (
		<div className="bg-white w-60 p-3 pt-11 flex flex-col">
			<p className='text-sm font-semibold text-textGray opacity-50 mb-1'>Chức năng chính</p>

			<div className="flex flex-1 flex-col gap-0.5">
				{DASHBOARD_SIDEBAR_LINKS.map((link) => (
					<SidebarLink key={link.key} link={link} />
				))}
			</div>
			
			<div className="flex flex-col gap-0.5 pt-2 rounded-md">
				<button onClick={logout} className={classNames(linkClass, 'cursor-pointer text-mainRed mb-2 hover:bg-lightRed ')}>
					<span className="text-xl">
						<HiOutlineLogout />
					</span>
					Đăng xuất
				</button>
			</div>
		</div>
	)
}

