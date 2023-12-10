import React, { useState, useEffect } from 'react';
import axios from 'axios';
import APIs from '../util/API';

export default function AdminInfo() {
    const [data, setdata] = useState({});

    useEffect(() => {
        const fetchApiData = async () => {
            let api_url =
                APIs.APIadminGetInfo +
                '/GetAdminInfo?id=' +
                document.cookie
                    .split('; ')
                    .find((cookie) => cookie.startsWith(`admin_cookie_id=`))
                    .split('=')[1];

            try {
                const response = await axios.get(api_url);
                setdata(response.data);
                console.log(response.data);
            } catch (error) {
                console.error('Error fetching data:', error);
            }
        };

        fetchApiData();
    }, []);

    return (
        <div>
            <div className="">
                <p>ID: {data.ID}</p>
                <p>Name: {data.Employee_Name}</p>
                <p>Gender: {data.Gender}</p>
                <p>Email: {data.Email}</p>
                <p>Store_ID: {data.Store_ID}</p>
                <p>Manager_ID: {data.Manager_ID}</p>
            </div>
        </div>
    );
}