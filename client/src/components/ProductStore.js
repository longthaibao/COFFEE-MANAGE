import React, { useMemo, useState, useEffect } from 'react';
import {MaterialReactTable, useMaterialReactTable} from 'material-react-table';
import axios from 'axios';
import Container from 'react-bootstrap/Container';
import moment from 'moment-timezone';



const API_URL = 'http://localhost:3001/api/admin'; 

const api = axios.create({
    baseURL: API_URL,
});
const storeID = document.cookie.split('; ').find((cookie) => cookie.startsWith(`storeID=`)).split('=')[1]

const getProductRevenue = async ({formatStart, formatEnd}) => {
    try {
        const response = await api.post('/getProRev', {
            store: storeID,
            start: formatStart,
            end: formatEnd
        });
        if (response.status == 200) {
            return response.data.data;
        }
    } catch (error) {
        console.error('Error fetching customers:', error);
        throw error;
    }
}

export default function ProRevTable({startDate, endDate, onDataFromChild}) {
    const formatStart = moment(startDate).format('YYYY-MM-DD');
    const formatEnd = moment(endDate).format('YYYY-MM-DD');
    const [data, setData] = useState([]);
    const [loading, setLoading] = useState(true);
    useEffect(() => {
        const fetchData = async () => {
            try {
                setLoading(true); 
                const productRevenueData = await getProductRevenue({formatStart, formatEnd});
                setData(productRevenueData);
                onDataFromChild(productRevenueData);
            } catch (error) {
                console.log("error: ", error);
            } finally {
                setLoading(false);
            }
        };
        fetchData();
    }, [formatStart, formatEnd]);

    const columns = useMemo(
        () => [{accessorKey: 'product_ID', header: 'ID', size: 150,},
          {accessorKey: 'product_name', header: 'Tên sản phẩm', size: 150,},
          {accessorKey: 'product_size', header: 'Size', size: 200,},
          {accessorKey: 'total_quantity_sold', header: 'Số lượng đã bán',size: 150,},
        ],[],
    );
    
    const table = useMaterialReactTable({
        columns,
        data, 
      });
    return (
        <Container style={{marginTop: "40px", width: "1150px", marginLeft: "42px", marginRight: "20px", fontFamily: 'Montserrat'}}>
            <MaterialReactTable table={table} />
        </Container>
    );
}
