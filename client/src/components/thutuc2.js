import React, { useState, useEffect } from 'react';
import axios from 'axios';
import APIs from '../util/API';

export default function Thutuc2() {
    const [data, setData] = useState([]);
    const [formData, setFormData] = useState(0);
    const [selectedYear, setSelectedYear] = useState(0);
    const [headers, setHeaders] = useState([]);

    const handleInputChange = (e) => {
        setFormData(e.target.value);
    };

    const handleYearChange = (e) => {
        setSelectedYear(e.target.value);
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            const response = await axios.post(APIs.APIadminThutuc2, {
                revenue: formData,
                year: selectedYear
            });

            setData(response.data);

            // Update headers based on the first item in the data array
            if (response.data.length > 0) {
                const newHeaders = Object.keys(response.data[0]);
                setHeaders(newHeaders);
            } else {
                setHeaders([]);
            }
        } catch (error) {
            console.error('Error submitting form:', error);
        }
    };

    const handleClearTable = () => {
        setData([]);
        setHeaders([]);
    };

    return (
        <div className="w-full flex justify-center items-center bg-cover">
            <div className="w-full h-222 bg-white rounded-2xl flex items-center flex-col p-4">
                <h1 className="text-gray-700 text-2xl font-bold mb-4">Thống kê các chương trình khuyến mãi có doanh thu lớn hơn hoặc bằng</h1>
                <form className="w-80" onSubmit={handleSubmit}>
                    <div className="mb-3">
                        <label htmlFor="revenue" className="block text-gray-700 text-base font-semibold mb-1">Có Doanh thu lớn hơn</label>
                        <input
                            type="number"
                            id="revenue"
                            name="revenue"
                            required
                            min={0}
                            placeholder="Nhập mức doanh thu"
                            className="w-full h-10 rounded-2xl border border-gray-200 px-4 text-base font-semibold bg-gray-100 outline-none"
                            value={formData}
                            onChange={handleInputChange}
                        />
                    </div>
                    <div className="mb-3">
                        <label htmlFor="year" className="block text-gray-700 text-base font-semibold mb-1">Trong năm</label>
                        <select
                            id="year"
                            name="year"
                            className="w-full h-10 rounded-2xl border border-gray-200 px-4 text-base font-semibold bg-gray-100 outline-none"
                            value={selectedYear}
                            onChange={handleYearChange}
                        >
                            {[...Array(new Date().getFullYear() - 2020)].map((_, index) => {
                                const year = 2021 + index;
                                return (
                                    <option key={year} value={year}>
                                        {year}
                                    </option>
                                );
                            })}
                            <option value={0}>Tất cả các năm</option>
                        </select>
                    </div>
                    <div className="flex space-x-4">
                        <button
                            type="submit"
                            className="w-1/2 h-10 rounded-full bg-blue-500 text-white transition duration-300 hover:bg-blue-800 flex items-center justify-center"
                        >
                            Nhập
                        </button>
                        <button
                            type="button"
                            className="w-1/2 h-10 rounded-full bg-red-500 text-white transition duration-300 hover:bg-red-800 flex items-center justify-center"
                            onClick={handleClearTable}
                        >
                            Xóa
                        </button>
                    </div>
                </form>
                <div className="mb-4 text-gray-600 text-sm text-red-500">
                    NOTE:
                    <p>Điều kiện áp dụng là số lớn hơn 1000 là điều kiện áp dụng đối với Khuyến mãi theo hóa đơn (Đơn vị: VNĐ)</p>
                    <p>Điều kiện áp dụng là số nhỏ là điều kiện áp dụng đối với Khuyến mãi theo sản phẩm</p>
                </div>
                {headers.length > 0 && (
                    <table className="w-full mt-4 border-collapse border" style={{ borderCollapse: 'collapse' }}>
                        <thead>
                            <tr>
                                {headers.map((header, index) => (
                                    <th key={index} className="bg-blue-500 text-white border border-white font-bold py-2 px-4">{header}</th>
                                ))}
                            </tr>
                        </thead>
                        <tbody>
                            {data.map((item, rowIndex) => (
                                <tr key={rowIndex}>
                                    {headers.map((header, colIndex) => (
                                        <td key={colIndex} className="border border-black p-2">{item[header]}</td>
                                    ))}
                                </tr>
                            ))}
                        </tbody>
                    </table>
                )}
            </div>
        </div>
    );
}
