import React from 'react';
import { shallow } from 'enzyme';

import Pagination from '../../components/Pagination';

const pagination = {
    currentPage: 1,
    totalPages: 4,
    setPageHandler: jest.fn()
};

test('should render without crashing', () => {
    shallow(
        <Pagination {...pagination} />
    );
});

test('should have correct container markup', () => {
    const component = shallow(
        <Pagination {...pagination} />
    );
    
    expect(component.find('.paginationWrapper').exists()).toBeTruthy();
    expect(component.find('.paginationWrapper').length).toBe(1);
});

test('should render correct amount of listItems', () => {
    const component = shallow(
        <Pagination {...pagination} />
    );

    expect(component.find('li').length).toEqual(4 + parseInt(pagination.totalPages, 10) )
});

test('should call setPageHandler with page Number', () => {
    const component = shallow(
        <Pagination {...pagination} />
    );
    
    expect(component.find('.paginationWrapper').exists()).toBeTruthy();
    
    const listItems = component.find('li a');
    listItems.map((listItem) => {
        listItem.simulate('click')
    });
    
    const calls = pagination.setPageHandler.mock.calls;
    calls.map((call) => {
        expect(call[0]).toEqual(expect.any(Number))
    });
});
