import 'whatwg-fetch';
import React from 'react';
import { shallow } from 'enzyme';

import App from '../App';
import Filters from '../components/filters';
import Sitters from '../components/sitters';
import Pagination from '../components/Pagination';

function mockFetch(data) {
    return jest.fn().mockImplementation(() =>
        Promise.resolve({
            ok: true,
            json: () => data
        })
    );
}

const mockState = {
    data: [{
        id: '123',
        attributes: {
            image: 'image.jpg',
            name: 'Dark Horse',
            ratingsScore: 2
        }
    }],
    meta: {
        currentPage: 1,
        totalPages: 5
    }
};

let component;

beforeAll(() => {
    global.fetch = jest.fn()
    global.fetch = mockFetch(mockState)
});


describe('<App />', () => {
    beforeEach(() => {
        component = shallow(
            <App />
        );
    
        component.setState({
            sitters: mockState.data,
            pagination: mockState.meta
        });
    });

    test('should render without crashing', () => {
        shallow(
            <App />
        );
    });
    
    test('should have correct container markup', () => {
        expect(component.find('.sitterListingWrapper').exists()).toBeTruthy();
        expect(component.find('.sitterListingWrapper').length).toBe(1);
        expect(component.find('h3').length).toBe(1);
        expect(component.find('h3').text()).toMatch('Sitters');
    });
    
    test('should have <Filters />', () => {
        expect(component.find(Filters).exists()).toBeTruthy();
    });
    
    test('should have <Sitters />', () => {
        expect(component.find(Sitters).exists()).toBeTruthy();
    });
    
    test('should have <Pagination />', () => {
        expect(component.find(Pagination).exists()).toBeTruthy();
    });

    test('should have correct sitterUrl endpoint', () => {
        const app = new App();
        expect(app.sitterUrl).toMatch('api/v1/sitters');
    })
});

describe('setPage', () => {
    test('should get sitters with valid page', () => {
        component.instance().ApiRequest = jest.fn();
        component.instance().setPage(1);
        component.instance().setPage(mockState.meta.totalPages);

        const mockedApiRequest = component.instance().ApiRequest;
        expect(mockedApiRequest).toHaveBeenCalledTimes(2);
        expect(mockedApiRequest.mock.calls[0][0]).toMatch(/page=1/)
        expect(mockedApiRequest.mock.calls[1][0]).toMatch(
            new RegExp(`page=${mockState.meta.totalPages}`)
        )
    });
    
    test('should get sitters with filter param', () => {
        component.instance().ApiRequest = jest.fn();
        component.setState({
            filters: {
                walkingDead: 'nextSeason'
            }
        });
        component.instance().setPage(1);

        const mockedApiRequest = component.instance().ApiRequest;
        expect(mockedApiRequest).toHaveBeenCalledTimes(1);
        expect(mockedApiRequest.mock.calls[0][0]).toMatch(/page=1&walkingDead=nextSeason/);
    });
    
    test('should not get sitters with invalid page', () => {
        component.instance().ApiRequest = jest.fn();
        component.instance().setPage();
        component.instance().setPage(0);
        component.instance().setPage(mockState.meta.totalPages + 1);

        const mockedApiRequest = component.instance().ApiRequest;
        expect(mockedApiRequest).not.toBeCalled();
    });
});

describe('filterByProperty', () => {
    const ApiRequestMock = jest.fn();

    beforeEach(() => {
        component.instance().ApiRequest = ApiRequestMock;
        ApiRequestMock.mockClear();
    });

    test('should set state with correct filters', () => {
        component.instance().filterByProperty('Rick', '2 and up');
        expect(component.state().filters).toEqual({
            filterBy: 'Rick',
            filterByValue: '2'
        });
    });

    test('should set state with sanitized filter value', () => {
        component.instance().filterByProperty('Rick', '2 and up');
        expect(component.state().filters).toEqual({
            filterBy: 'Rick',
            filterByValue: '2'
        });
    });

    test('should call ApiRequest with correct url', () => {
        component.instance().filterByProperty('Rick', '2 and up');
        expect(ApiRequestMock).toHaveBeenCalledTimes(1);
        expect(ApiRequestMock.mock.calls[0][0])
            .toMatch(/api\/v1\/sitters\?filterBy=Rick&filterByValue=2&page=1/);
    });

    describe('invalid or default arguments', () => {
        let setPage;
        let filterByProperty;

        beforeEach(() => {
            setPage = component.instance().setPage = jest.fn();
            setPage.mockClear();
        });

        test('should clear state with missing arguments', () => {
            component.setState({
                filters: { someFilter: 'aValue' }
            });
            component.instance().filterByProperty();
            expect(component.state().filters).toEqual({});
            expect(setPage).toHaveBeenCalledTimes(1);
            expect(setPage.mock.calls[0][0]).toBe(1);
        });

        test('should clear state with missing value', () => {
            component.setState({
                filters: { someFilter: 'aValue' }
            });
            component.instance().filterByProperty('property');
            expect(component.state().filters).toEqual({});
            expect(setPage).toHaveBeenCalledTimes(1);
        });

        test('should clear state with default value', () => {
            component.setState({
                filters: { someFilter: 'aValue' }
            });
            component.instance().filterByProperty('property', 'default');
            expect(component.state().filters).toEqual({});
            expect(setPage).toHaveBeenCalledTimes(1);
        });
    });
});

describe('ApiRequest', () => {
    beforeEach(() => {
        component = shallow(
            <App />
        );
    
        component.setState({
            sitters: mockState.data,
            pagination: mockState.meta
        });
    });

    test('checkStatus should return resolved Promise', () => {
        expect.assertions(1)
        return component.instance().checkStatus({
            ok: true
        }).then(res => {
            expect(res.ok).toBe(true)
        });
    });
    
    test('checkStatus should return rejected Promise', () => {
        expect.assertions(1)
        return component.instance().checkStatus({
            ok: false,
            statusText: 'An error happened!'
        }).catch(res => {
            expect(res).toEqual(expect.any(Error))
        });
    });
    
    test('ApiRequest should call fetch with correct args', () => {
        global.fetch.mockClear();

        const url = 'fake.com';
        component.instance().ApiRequest(url);
        expect(global.fetch).toBeCalledWith(
            url,
            {
                accept: "application/json"
            }
        )

        component.instance().ApiRequest(url, { fakeOption: 'Yep. I am fake' });
        expect(global.fetch).toBeCalledWith(
            url,
            {
                accept: "application/json",
                fakeOption: 'Yep. I am fake'
            }
        )
    });
});

