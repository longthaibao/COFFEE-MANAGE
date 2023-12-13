import React, { useState, useEffect } from 'react';
import axios from 'axios';


const API_URL = 'http://localhost:3001/api/admin/order'; // Replace with your actual API URL

const api = axios.create({
    baseURL: API_URL,
});

const apiEndpoints = {
    getOrder: async () => {
        try {
            const response = await api.get('/getOrder');
            //console.log("Customer:", response.data);
            return response.data;
        } catch (error) {
            console.error('Error fetching customers:', error);
            throw error;
        }
    },
    viewOrder: async () => {
        try {
            const response = await api.get('/viewOrder');
            //console.log("Customer:", response.data);
            return response.data;
        } catch (error) {
            console.error('Error fetching customers:', error);
            throw error;
        }
    },
    getDetailBill: async (BID) => {
        try {
            console.log("BID", BID);
            const formData = new FormData();
            formData.append('BID', BID);
            console.log("FormData:", ...formData);
            const response = await api.post('/getdetailbill', BID);
            return response.data;
        } catch (error) {
            console.error('Error fetching bill:', error);
            throw error;
        }
    },

    updateCustomer: async (updatedCustomer) => {
        try {
            const response = await api.put('/updateCustomer', updatedCustomer);
            return response.data;
        } catch (error) {
            console.error('Error updating customer:', error);
            throw error;
        }
    },
    deleteOrder: async (phone) => {
        try {
            console.log('phone DL:', phone);
            const formData = new FormData();
            formData.append('phone', phone);
            const response = await api.delete('/deleteCustomer', { data: formData });
            return response.data;
        } catch (error) {
            console.error('Error deleting customer:', error);
            throw error;
        }
    },
};

export default apiEndpoints;