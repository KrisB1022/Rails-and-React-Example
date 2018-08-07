import React, { Component } from 'react';
import './App.css';
import Sitters from './components/sitters'
import Filters from './components/filters'
import Pagination from './components/Pagination'

class App extends Component {
  constructor() {
    super()
    
    this.setPage = this.setPage.bind(this);
    this.sitterUrl = 'api/v1/sitters';
    this.state = {
      sitters: []
    }
  }

  checkStatus(res) {
    if(res.ok) {
      return Promise.resolve(res);
    } else {
      return Promise.reject(new Error(res.statusText))
    }
  }

  ApiRequest(url, opts={}) {
    const options = {
      accept: 'application/json',
      ...opts
    }

    fetch(url, options)
      .then(this.checkStatus)
      .then((res) => res.json())
      .then((res) => {
        this.setState({
          sitters: res.data,
          pagination: {
            currentPage: parseInt(res.meta.currentPage, 10),
            totalPages: parseInt(res.meta.totalPages, 10)
          }
        })
      })
  }

  componentWillMount() {
    this.ApiRequest(this.sitterUrl);
  }

  setPage(page) {
    if(!page || page < 1 || page > this.state.pagination.totalPages) {
      return
    }

    let filterQuery = '';
    for(let key in this.state.filters) {
      filterQuery += `&${key}=${this.state.filters[key]}`
    }

    this.ApiRequest(`${this.sitterUrl}?page=${page}${filterQuery}`);
  }

  filterByProperty(property, value) {
    if(!property || !value || value === 'default') {
      this.setState({ 
        filters: {}
      });
      
      return this.setPage(1)
    }

    const sanitizedValue = value.replace(/[^\d]/g, '');
    this.setState({
      filters: {
        filterBy: property,
        filterByValue: sanitizedValue
      }
    });

    this.ApiRequest(`${this.sitterUrl}?filterBy=${property}&filterByValue=${sanitizedValue}&page=1`)
  }

  render() {
    return (
      <div className="container sitterListingWrapper">
        <div className="row">
          <div className="col-sm">
            <h3>Sitters</h3>
          </div>
        </div>

        <div className="row">
          <Filters 
            filterByProperty={this.filterByProperty}
          />

          <div className="col-md">
            {this.state.sitters &&
              <Sitters 
                sitters={this.state.sitters}
              />
            }
    
            {this.state.pagination &&
              <Pagination 
                {...this.state.pagination}
                setPageHandler={this.setPage} 
              />
            }
          </div>
        </div>
      </div>
    );
  }
}

export default App;
