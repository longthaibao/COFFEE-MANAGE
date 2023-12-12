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
    insertCustomer: async (newCustomer) => {
        try {
            const response = await api.post('/insertCustomer', newCustomer);
            return response.data;
        } catch (error) {
            console.error('Error inserting customer:', error);
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